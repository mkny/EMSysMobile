//
//  rezBrowserViewController.m
//  emsysmobile
//
//  Created by Marcony Neves on 05/06/14.
//  Copyright (c) 2014 Rezende Sistemas. All rights reserved.
//

#import "rezBrowserViewController.h"

@interface rezBrowserViewController ()

@end

@implementation rezBrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [_loader startAnimating];
    
    
    // Do any additional setup after loading the view.
    
    _domain = @"http://mobile.emsys.com.br";
    _path = @"/";
    
    NSString *site = [_domain stringByAppendingString:_path];
    
    //NSString *authUrl = [site stringByAppendingString:@"admin/auth/"];
    NSString *authUrl = [site stringByAppendingString:@"site/auth/"];
    
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@", _username, _password];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:authUrl]];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    [_webView loadRequest:request];
    [_webView setDelegate:self];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [_loader stopAnimating];
    NSString *link = [[webView.request.URL path] substringFromIndex:[_path length]];

    if([link isEqualToString:@"index/index/erro/true/type/login"]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *link = [[request.URL path] substringFromIndex:[_path length]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    NSLog(@"Receiving URL \"%@\"", link);
    
    if([link isEqualToString:@"site/auth/logout"]) {
        // LOGOUT
        [prefs setObject:@"" forKey:@"password"];
        [prefs setObject:@"" forKey:@"username"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        return NO;
    } else if([link isEqualToString:@"index/index/erro/true/type/login"]) {
        [prefs setObject:@"" forKey:@"password"];
        [prefs setObject:@"" forKey:@"username"];
        [prefs setObject:@"login" forKey:@"error"];
        
        _webView.alpha = 0;
        
        return YES;
    } else {
        NSLog(@"Not handled URL: %@", link);
        
        return YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
