//
//  ViewController.m
//  MultiPhoto
//
//  Created by demo on 2014/09/12.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "MutiPhotoViewController.h"
#import "MyImageView.h"
#import <AVFoundation/AVFoundation.h>

@interface MutiPhotoViewController ()

@property (strong, nonatomic) UIView *insideView;
@property (strong, nonatomic) AVAudioPlayer *player;
- (void)playSound:(NSTimer *)fired;

@end

@implementation MutiPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource: @"music"
                                                          ofType: @"m4a"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath: musicPath]
                                                         error: nil];
    [self.player prepareToPlay];
    self.player.numberOfLoops = 100;
 //   [self.player play];
    [NSTimer scheduledTimerWithTimeInterval: 2.0
                                     target: self
                                   selector: @selector(playSound:)
                                   userInfo: nil
                                    repeats: NO];
    CGFloat panelWidth = 1000.0;
    CGFloat panelHeight = 1000.0;
    
    NSArray *photoFiles = @[@"photo1", @"photo2", @"photo3",
                            @"photo4", @"photo5", @"photo6"];
    NSInteger count_x = (NSInteger)sqrt( photoFiles.count );
    NSInteger count_y = photoFiles.count / count_x;
    
    CGRect backRect = CGRectMake( 0.0, 0.0, panelWidth, panelHeight);
    self.insideView = [[UIView alloc] initWithFrame: backRect];
    UIScrollView *scrollView = (UIScrollView *)self.view;
    [scrollView addSubview: self.insideView];
    scrollView.contentSize = CGSizeMake(panelWidth, panelHeight);
    NSInteger x = 0, y = 0;
    for (NSString *oneItem in photoFiles)   {
        NSString *path = [[NSBundle mainBundle] pathForResource: oneItem
                                                         ofType: @"jpg"];
        CGRect imageFrame = CGRectMake(x * panelWidth / count_x,
                                       y * panelHeight / count_y,
                                       panelWidth / count_x,
                                       panelHeight /  count_y);
        MyImageView *oneImage = [[MyImageView alloc] initWithFrame: imageFrame];
        oneImage.userInteractionEnabled = YES;
        oneImage.image = [UIImage imageWithContentsOfFile: path];
        [self.insideView addSubview: oneImage];
        x++;
        if (x >= count_x)   {
            x = 0;
            y++;
        }
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.insideView;
}

- (void)playSound:(NSTimer *)fired
{
    [self.player play];	//演奏開始
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
