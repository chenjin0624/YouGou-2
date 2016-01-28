//
//  YGAdvertViewController.m
//  YouGou
//
//  Created by merlin on 1/25/16.
//  Copyright © 2016 merlin. All rights reserved.
//

#import "YGAdvertViewController.h"

@interface YGAdvertViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation YGAdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yougou58.com/category.php?id=42"]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)clickNavigationBarBackBtnAction:(id)sender
{
    [self.navigationController removeFromParentViewController];
    [self.navigationController.view removeFromSuperview];
}

@end
