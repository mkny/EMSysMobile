//
//  rezViewController.h
//  emsysmobile
//
//  Created by Marcony Neves on 13/05/14.
//  Copyright (c) 2014 Rezende Sistemas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rezBrowserViewController.h"

@interface rezViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) NSUserDefaults *prefs;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@property (weak, nonatomic) IBOutlet UIImageView *logosys;

@property (weak, nonatomic) IBOutlet UIImageView *logoRezende;
@property (weak, nonatomic) IBOutlet UIImageView *logoNet4biz;
@property (weak, nonatomic) IBOutlet UIImageView *logoLinx;


@property (weak, nonatomic) IBOutlet UIImageView *logoRezende_2;

@end
