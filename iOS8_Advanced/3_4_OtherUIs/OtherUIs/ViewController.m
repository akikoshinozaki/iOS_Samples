//
//  ViewController.m
//  2_5_OtherUIs
//
//  Created by Masayuki Nii on 2013/12/29.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"

@interface ViewController ()

//@property (nonatomic) BOOL isShowingPopover;
//@property (nonatomic, strong) NSBlockOperation *disapearPopover;
@property (nonatomic, weak) UITextField *textInAlert;

//- (IBAction)tapButton1:(id)sender;
//- (IBAction)tapButton2:(id)sender;
//- (IBAction)tapButton3:(id)sender;
//- (IBAction)tapButton4:(id)sender;
- (IBAction)tapButton5:(id)sender;
- (IBAction)tapButton6:(id)sender;


- (void)showAlertView:(id)sender;
- (void)showActionSheet:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.isShowingPopover = NO;
//    self.disapearPopover = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, NSStringFromClass([segue class]));
#endif
//    if ([NSStringFromClass([segue class])
//         isEqualToString: @"UIStoryboardPopoverPresentationSegue"])    {
//        UIStoryboardPopoverSegue *popSegue = (UIStoryboardPopoverSegue *)segue;
//        SubViewController *vc = popSegue.destinationViewController;
//        vc.myPopover = popSegue.popoverController;
//    }
//    NSString *identifier = segue.identifier;
//    SubViewController *nextVC = [segue destinationViewController];
//    if ( [identifier isEqualToString: @"popover1"]
//        || [identifier isEqualToString: @"popover2"])    {
//        if (! self.isShowingPopover)   {
//            self.isShowingPopover = YES;
//            UIPopoverController *pop = [(UIStoryboardPopoverSegue*)segue popoverController];
//            nextVC.myPopover = pop;
//            nextVC.doAfterDisappear = [NSBlockOperation blockOperationWithBlock: ^(){
//#ifdef DEBUG
//                NSLog( @"%s[A]", __FUNCTION__);
//#endif
//                self.isShowingPopover = NO;
//            }];
//            self.disapearPopover = [NSBlockOperation blockOperationWithBlock: ^(){
//#ifdef DEBUG
//                NSLog( @"%s[B]", __FUNCTION__);
//#endif
//                [pop dismissPopoverAnimated: YES];
//            }];
//        }
//    } else if ( [identifier isEqualToString: @"modal1"])    {
//        nextVC.isModalDialog = YES;
//        if (self.isShowingPopover)  {
//            [self.disapearPopover main];
//        }
//    }
//
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    //    if ( [identifier isEqualToString: @"popover1"]
    //        || [identifier isEqualToString: @"popover2"])    {
    //        return ! self.isShowingPopover;
    //    }
    return YES;
}

//- (IBAction)tapButton1:(id)sender {
//#ifdef DEBUG
//    NSLog( @"%s", __FUNCTION__);
//#endif
//}
//
//- (IBAction)tapButton2:(id)sender {
//#ifdef DEBUG
//    NSLog( @"%s", __FUNCTION__);
//#endif
//    self.isShowingPopover = YES;
//}
//
//- (IBAction)tapButton3:(id)sender {
//#ifdef DEBUG
//    NSLog( @"%s", __FUNCTION__);
//#endif
//}
//
//- (IBAction)tapButton4:(id)sender {
//}
//
- (IBAction)tapButton5:(id)sender {
    [self showAlertView: self];
}

- (IBAction)tapButton6:(id)sender {
    [self showActionSheet: sender];
}

- (IBAction)tapAlertController: (id)sender {
    UIAlertController* alert
    = [UIAlertController alertControllerWithTitle: @"My Alert"
                                          message: @"This is my message."
     //                             preferredStyle: UIAlertControllerStyleAlert];
                                 preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertController* __weak weakAlert = alert;
    
    alert.popoverPresentationController.permittedArrowDirections = UIMenuControllerArrowDown;
    alert.popoverPresentationController.barButtonItem = sender;
    
    UIAlertAction* defaultAction
    = [UIAlertAction actionWithTitle: @"OK"
                               style: UIAlertActionStyleDefault
                             handler:
       ^(UIAlertAction * action) {
           [weakAlert dismissViewControllerAnimated: YES
                                         completion: nil];
           NSLog(@"Input = %@", self.textInAlert.text);
       }];
    [alert addAction: defaultAction];
    
    UIAlertAction* cancelAction
    = [UIAlertAction actionWithTitle: @"Cancel"
                               style: UIAlertActionStyleCancel
                             handler:
       ^(UIAlertAction * action) {
           [weakAlert dismissViewControllerAnimated: YES
                                         completion: nil];
       }];
    [alert addAction: cancelAction];
    
    UIAlertAction* altAction
    = [UIAlertAction actionWithTitle: @"Another"
                               style: UIAlertActionStyleDestructive
                             handler:
       ^(UIAlertAction * action) {
           [weakAlert dismissViewControllerAnimated: YES
                                         completion: nil];
       }];
    [alert addAction: altAction];
    
//       [alert addTextFieldWithConfigurationHandler:
//       ^(UITextField *textField){
//          NSLog(@"%s", __FUNCTION__);
//           self.textInAlert = textField;
//      }];
 
    [self presentViewController: alert
                       animated: YES
                     completion: nil];
}

- (void)showAlertView:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"My App"
                          message: @"Do you know me?"
                          delegate: self
                          cancelButtonTitle: @"Cancel"
                          otherButtonTitles: @"Yes, I do.", @"No, I don't", nil];
    //    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
    NSLog(@"Alert is showing");
}

- (void)    alertView:(UIAlertView *)alertView
 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert Button Click = %d", buttonIndex);
}

- (void)showActionSheet:(id)sender
{
    //UIBarButtonItem *tappedItem = sender;
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle: @"My App"
                            delegate: self
                            cancelButtonTitle: @"Are you sleepy?"
                            destructiveButtonTitle: @"Not at all."
                            otherButtonTitles: @"Yes, I am", @"Sleeping", nil];
    [sheet showInView: self.view];
    //[sheet showFromBarButtonItem:sender animated:YES];
    // [sheet showFromToolbar: self.navigationController.toolbar];
    NSLog(@"Action Sheet is showing");
}


- (void)  actionSheet:(UIActionSheet *)actionSheet
 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Action Sheet Button Click = %d", buttonIndex);
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"Action Sheet Button Click = Cancel");
}


@end
