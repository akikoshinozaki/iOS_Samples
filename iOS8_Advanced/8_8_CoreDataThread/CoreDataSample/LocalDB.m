//
//  LocalDB.m
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/02.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "LocalDB.h"
#import "People.h"
#import "Company.h"

@interface LocalDB()

@property (nonatomic, strong) NSEntityDescription *entityDescPeople;
@property (nonatomic, strong) NSEntityDescription *entityDescCompany;
@property (nonatomic, strong) NSManagedObjectContext *moContext;

@property (nonatomic, strong) NSMutableArray *parsedData;
@property (nonatomic, strong) NSMutableDictionary *currentRecord;
@property (nonatomic, strong) NSMutableString *currentString;

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSPersistentStore *pStore;
@property (nonatomic, strong) NSPersistentStoreCoordinator *pStoreCoordinator;

- (void)readFromXMLFiles;

@end

@implementation LocalDB

-(instancetype) init
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    self = [super init];
    
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.maxConcurrentOperationCount = 1;
    
    NSError *error = nil;
    NSURL *modelURL
    = [[NSBundle mainBundle] URLForResource: @"Model"
                              withExtension: @"momd"];
    NSManagedObjectModel *model
    = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL];
    
    self.pStoreCoordinator
    = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *storeURL = [fm URLsForDirectory: NSDocumentDirectory
                                 inDomains: NSUserDomainMask][0];
    storeURL = [storeURL URLByAppendingPathComponent: @"localdb.sqlite"];
    self.pStore
    = [self.pStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType
                                           configuration: nil
                                                     URL: storeURL
                                                 options: nil
                                                   error: &error];
    if ( self.pStore == nil )	{
        NSLog( @"Error Description: %@", [error userInfo] );
        return nil;
    }
    
#ifdef SESSION1
    [self.queue addOperationWithBlock: ^(void){
        self.moContext = [[NSManagedObjectContext alloc] init];
#endif
#ifdef SESSION2
        self.moContext
        = [[NSManagedObjectContext alloc]
           initWithConcurrencyType: NSMainQueueConcurrencyType];
#endif
        self.moContext.persistentStoreCoordinator = self.pStoreCoordinator;
        self.entityDescPeople = [NSEntityDescription entityForName: @"People"
                                            inManagedObjectContext: self.moContext];
        self.entityDescCompany = [NSEntityDescription entityForName: @"Company"
                                             inManagedObjectContext: self.moContext];
#ifdef SESSION1
    }];
    [self.queue waitUntilAllOperationsAreFinished];
#endif
    
    NSArray *peopleInDB = [self selectedPeople: nil orderBy: nil];
    if ( peopleInDB.count < 1 ) {
        [self readFromXMLFiles];
    }
    
    self.selectedData = [self selectedPeople: nil orderBy: nil];
    
    return self;
}

-(void) clearAllRecords
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSArray *array = [self selectedPeople: nil orderBy: nil];
    for ( People *person in array )	{
        [self.moContext deleteObject: person];
    }
    array = [self selectedCompany: nil orderBy: nil];
    for ( Company *company in array )	{
        [self.moContext deleteObject: company];
    }
    NSError *error = nil;
    [self.moContext save: &error];
    if ( error != nil )	{
        NSLog( @"ERROR: %@", [error	description] );
    }
}

-(NSArray *) selectedPeople: (NSString *)criteria orderBy: (NSString *)field
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    __block NSArray *array;
    __block NSError *error = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"People"];
    
    if ( criteria != nil )  {
        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithFormat: @"name BEGINSWITH %@", criteria];
        [request setPredicate: predicate];
    }
    
    if ( field != nil)  {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: field
                                                                       ascending: NO];
        [request setSortDescriptors: @[sortDescriptor]];
    }
#ifdef SESSION1
    [self.queue addOperationWithBlock: ^(void){
        NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
        array = [self.moContext executeFetchRequest: request
                                              error: &error];
    }];
    [self.queue waitUntilAllOperationsAreFinished];
#endif
#ifdef SESSION2
    NSManagedObjectContext *context
    = [[NSManagedObjectContext alloc]
       initWithConcurrencyType: NSPrivateQueueConcurrencyType];
    context.parentContext = self.moContext;
    //    context.persistentStoreCoordinator = self.pStoreCoordinator;
    
    [context performBlockAndWait: ^(void){
        NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
        array = [context executeFetchRequest: request
                                       error: &error];
    }];
#endif
    if (array == nil)    {
        NSLog( @"ERROR: %@", error.description );
    }
    //    NSLog(@"%@", array);
    return array;
}

-(NSArray *) selectedCompany: (NSString *)criteria orderBy: (NSString *)field
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    __block NSArray *array;
    __block NSError *error = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Company"];
    
    if ( criteria != nil )  {
        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithFormat: @"company BEGINSWITH %d", criteria];
        [request setPredicate: predicate];
    }
    
    if ( field != nil)  {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: field
                                                                       ascending: NO];
        [request setSortDescriptors: [NSArray arrayWithObject: sortDescriptor]];
    }
#ifdef SESSION1
    [self.queue addOperationWithBlock: ^(void){
        NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
        array = [self.moContext executeFetchRequest: request
                                              error: &error];
    }];
    [self.queue waitUntilAllOperationsAreFinished];
#endif
#ifdef SESSION2
    NSManagedObjectContext *context
    = [[NSManagedObjectContext alloc]
       initWithConcurrencyType: NSPrivateQueueConcurrencyType];
    context.parentContext = self.moContext;
    //    context.persistentStoreCoordinator = self.pStoreCoordinator;
    
    [context performBlockAndWait: ^(void){
        NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
        array = [context executeFetchRequest: request
                                       error: &error];
    }];
#endif
    if (array == nil)    {
        NSLog( @"ERROR: %@", error.description );
    }
    return array;
}

-(void)readFromXMLFiles
{
    NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
    
    NSURL *targetFile = [resourceURL URLByAppendingPathComponent: @"company.xml"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL: targetFile];
    parser.delegate = self;
    self.parsedData = [NSMutableArray array];
    if( ! [parser parse] )  {
        NSLog( @"Error in parsing xml file." );
        return;
    }
    
    NSError *error;
    NSMutableDictionary *resultHash = [NSMutableDictionary dictionary];
    [self.parsedData enumerateObjectsUsingBlock:
     ^(NSDictionary *record, NSUInteger idx, BOOL *stop){
         Company *company = [[Company alloc] initWithEntity: self.entityDescCompany
                             insertIntoManagedObjectContext: self.moContext];
         company.company = record[@"company"];
         company.zip = record[@"zip"];
         company.section = record[@"section"];
         company.address = record[@"address"];
         resultHash[record[@"id"]] = company;
     }];
    
    targetFile = [resourceURL URLByAppendingPathComponent: @"people.xml"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL: targetFile];
    parser.delegate = self;
    self.parsedData = [NSMutableArray array];
    if( ! [parser parse] )  {
        NSLog( @"Error in parsing xml file." );
        return;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat: @"yyyy/MM/dd"];
    
    [self.parsedData enumerateObjectsUsingBlock:
     ^(NSDictionary *record, NSUInteger idx, BOOL *stop){
         People *person = [[People alloc] initWithEntity: self.entityDescPeople
                          insertIntoManagedObjectContext: self.moContext];
         person.name = record[@"name"];
         person.mail = record[@"mail"];
         person.phone = record[@"phone"];
         person.prefecture = record[@"prefecture"];
         person.birthday = [fmt dateFromString: record[@"birthday"]];
         person.company = resultHash[record[@"company_id"]];
     }];
    [self.moContext save: &error];
}


#pragma - NSXMLParser Delegate Methods

- (void)    parser: (NSXMLParser *)parser
   didStartElement: (NSString *)elementName
      namespaceURI: (NSString *)namespaceURI
     qualifiedName: (NSString *)qualifiedName
        attributes: (NSDictionary *)attributeDict
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    if ( [elementName isEqualToString: @"record"] )    {
        self.currentRecord = [NSMutableDictionary dictionary];
    } else    {
        self.currentString = [NSMutableString string];
    }
}

- (void)    parser: (NSXMLParser *)parser
   foundCharacters: (NSString *)string
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    if ( self.currentString != nil )   {
        [self.currentString appendString: string];
    }
}

- (void)    parser: (NSXMLParser *)parser
     didEndElement: (NSString *)elementName
      namespaceURI: (NSString *)namespaceURI
     qualifiedName: (NSString *)qName
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    if ( [elementName isEqualToString: @"record"] )    {
        [self.parsedData addObject: self.currentRecord];
        self.currentRecord = nil;
    } else    {
        [self.currentRecord setObject: self.currentString
                               forKey: elementName];
        self.currentString = nil;
    }
}

@end
