//
//  rezBrowserViewController.h
//  emsysmobile
//
//  Created by Marcony Neves on 05/06/14.
//  Copyright (c) 2014 Rezende Sistemas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rezBrowserViewController : UIViewController <UIWebViewDelegate>


@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@property (strong, nonatomic) NSString *domain;
@property (strong, nonatomic) NSString *path;

//@property (strong, nonatomic) UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
