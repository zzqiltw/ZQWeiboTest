//
//  ZQOAuthController.m
//  ZQWeibo
//
//  Created by zzqiltw on 15-1-21.
//  Copyright (c) 2015年 zzqiltw. All rights reserved.
//

#import "ZQOAuthController.h"
#import <MBProgressHUD.h>
#import "ZQHTTPTool.h"

@interface ZQOAuthController ()<UIWebViewDelegate>

@end

@implementation ZQOAuthController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:ZQLoginURL] cachePolicy:0 timeoutInterval:10.0f];
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"请稍等噢";
    hud.removeFromSuperViewOnHide = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
    NSString *code = nil;
    if (range.length > 0) {
        code = [request.URL.absoluteString substringFromIndex:(range.location + range.length)];
        [self dealWithCode:code];
        [ZQRootVCTool selectRootVC];
        return NO;
    }
    return YES;
}

- (void)dealWithCode:(NSString *)code
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"client_id"] = ZQAppKey;
    dict[@"client_secret"] = ZQAppSecret;
    dict[@"grant_type"] = @"authorization_code";
    dict[@"code"] = code;
    dict[@"redirect_uri"] = ZQRedirectURI;
    
    [ZQHTTPTool postWithUrlStr:@"https://api.weibo.com/oauth2/access_token" params:dict success:^(id responseObject) {
        ZQAccount *account = [ZQAccount accountWithDict:responseObject];
        [ZQAccountTool saveAccount:account];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}
@end
