//
//  AppDelegate.h
//  PlaceMap
//
//  Created by demo on 2014/09/14.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceDatabase;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PlaceDatabase *placeDB;

@end

