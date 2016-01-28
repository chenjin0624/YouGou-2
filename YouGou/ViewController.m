//
//  ViewController.m
//  YouGou
//
//  Created by merlin on 1/25/16.
//  Copyright © 2016 merlin. All rights reserved.
//

#import "ViewController.h"
#import "YGLaunchViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "YGGVUserDefaults.h"
#import "UIImageView+WebCache.h"
#import "UMOnlineConfig.h"
#import "UIView+YINHU.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) UINavigationController* launchViewControllerNav;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initData];
    
    [self initLaunchView];
    
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
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yougou58.com/"]]];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:@"http://7xqgzn.com1.z0.glb.clouddn.com/YougouProperty_1.plist"]];
        
        NSLog(@"dic is %@",dic);
        
        [GVUserDefaults standardUserDefaults].advertContentUrl = [dic objectForKey:@"advertContentUrl"];
        [GVUserDefaults standardUserDefaults].advertImageUrl = [dic objectForKey:@"advertImageUrl"];
        [GVUserDefaults standardUserDefaults].advertTime = [dic objectForKey:@"advertTime"];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[GVUserDefaults standardUserDefaults].advertImageUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([[GVUserDefaults standardUserDefaults].advertTime floatValue] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSDictionary* dic = [UMOnlineConfig getConfigParams];
                if([[dic objectForKey:@"off_synupdate"] boolValue]){
                    [self.view alert:@"connect error"];
                }
            });
            
        }];
        
    });
}

- (void)initLaunchView
{
    if([GVUserDefaults standardUserDefaults].advertImageUrl.length && [[[SDWebImageManager sharedManager] imageCache] imageFromDiskCacheForKey:[GVUserDefaults standardUserDefaults].advertImageUrl]){
        
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        self.launchViewControllerNav = [storyBoard instantiateViewControllerWithIdentifier:@"YGLaunchViewControllerNav"];
        
        [self addChildViewController:self.launchViewControllerNav];
        
        [self.view addSubview:self.launchViewControllerNav.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([[GVUserDefaults standardUserDefaults].advertTime floatValue] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            if(1 == self.launchViewControllerNav.viewControllers.count){
                
                [UIView animateWithDuration:1.0f animations:^{
                    
                    self.launchViewControllerNav.view.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
                    self.launchViewControllerNav.view.alpha = 0.1f;
                    
                } completion:^(BOOL finished) {
                    
                    [self.launchViewControllerNav removeFromParentViewController];
                    [self.launchViewControllerNav.view removeFromSuperview];
                    self.launchViewControllerNav = nil;
                }];
                
            }
        });
        
        
    }
}


@end
