//
//  YGLaunchViewController.m
//  YouGou
//
//  Created by merlin on 1/25/16.
//  Copyright © 2016 merlin. All rights reserved.
//

#import "YGLaunchViewController.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPRequestOperationManager.h"
#import "YGGVUserDefaults.h"
#import "GVUserDefaults.h"

@interface YGLaunchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YGLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)initData
{
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.leftBarButtonItem = nil;
    
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[GVUserDefaults standardUserDefaults].advertImageUrl]];
    
    UITapGestureRecognizer* tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    [self.imageView addGestureRecognizer:tapGes];
    
    //get network launch image
}

- (void)initView
{
    
}

- (IBAction)jumpToAction:(id)sender
{
    [UIView animateWithDuration:1.0f animations:^{
        
        self.view.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        self.view.alpha = 0.1f;
        
    } completion:^(BOOL finished) {
        
        [self.navigationController removeFromParentViewController];
        [self.navigationController.view removeFromSuperview];

    }];
}

- (void)tapImageView:(id)sender
{
    [self performSegueWithIdentifier:@"LaunchToAdvert" sender:nil];
}

@end
