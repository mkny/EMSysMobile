//
//  rezViewController.m
//  emsysmobile
//
//  Created by Marcony Neves on 13/05/14.
//  Copyright (c) 2014 Rezende Sistemas. All rights reserved.
//

#import "rezViewController.h"
#import "Reachability.h"

@interface rezViewController ()

@end

@implementation rezViewController

-(void) viewDidAppear:(BOOL)animated {
    [self viewStart];
    
    NSString *error = [_prefs stringForKey:@"error"];
    
    if (error && [error isEqualToString:@"login"]) {
        [self aviso:@"Erro" withMessageOrNil:@"Usuário e/ou Senha Incorretos"];
        [_prefs setObject:@"" forKey:@"error"];
    } else {
        if ([self loadDefaults] && [self shouldPerformSegueWithIdentifier:@"doLogin" sender:self]) {
            [self performSegueWithIdentifier:@"doLogin" sender:self];
        }
    }
}

- (BOOL) loadDefaults {
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *user = [_prefs stringForKey:@"username"];
    NSString *pass = [_prefs stringForKey:@"password"];
    
    if (pass && ![pass isEqualToString:@""]) {
        _password.text = pass;
    }
    
    if (user && ![user isEqualToString:@""]) {
        _username.text = user;
    }
    
    return [self validarCampos];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [(UIScrollView *) self.view setContentSize:self.view.frame.size];
    
    _prefs = [NSUserDefaults standardUserDefaults];
    
//    NSString *uuid = [[[[UIDevice alloc] init] identifierForVendor] UUIDString];
//    NSLog(@"%@", uuid);
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    
    return NO;
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"doLogin"]) {
        // Validacao dos campos nao preenchidos, antes de enviar pro servidor;
        if (![self validarCampos]) {
            [self aviso:@"Erro" withMessageOrNil:@"Por favor, preencha os campos corretamente"];
            
            return NO;
        }
        
//        Reachability *reach = [Reachability reachabilityWithHostName:@"http://mobile.emsys.com.br"];
//        NetworkStatus networks = [reach currentReachabilityStatus];
//        if(networks == NotReachable){
//            return NO;
//        }
        
        // Envia
        return YES;
    }
    
    return YES;
}


- (BOOL) validarCampos {
    if([_username.text isEqualToString:_username.placeholder]){
        return NO;
    }
    
    if([_username.text isEqualToString:_username.placeholder]){
        return NO;
    }
    
    return YES;
}

- (void)viewStart {
    
    _submit.layer.borderWidth = 0.5f;
    _submit.layer.cornerRadius = 5;
    
//    _submit.alpha = _username.alpha = _password.alpha = 0;
    
    
    [_username setLeftViewMode:UITextFieldViewModeAlways];
    [_password setLeftViewMode:UITextFieldViewModeAlways];
    
    UIImage *sprite = [UIImage imageNamed:@"sprite.png"];
    
    
    CGRect cropRect_mail = CGRectMake(0.0, 55.0, 22.0, 16.0);
    CGRect cropRect_pass = CGRectMake(0.0, 173.0, 22.0, 25.0);
    
    CGImageRef imageMail = CGImageCreateWithImageInRect([sprite CGImage], cropRect_mail);
    CGImageRef imagePass = CGImageCreateWithImageInRect([sprite CGImage], cropRect_pass);
    
    UIImage *icon_email = [UIImage imageWithCGImage:imageMail];
    UIImage *icon_pass = [UIImage imageWithCGImage:imagePass];
    
    CGImageRelease(imageMail);
    CGImageRelease(imagePass);
    
    [_username setLeftView:[[UIImageView alloc] initWithImage: icon_email]];
    [_password setLeftView:[[UIImageView alloc] initWithImage: icon_pass]];
    
    
    
    UIImage *logos = [UIImage imageNamed:@"logos.png"];
    
    CGRect logo_rezende = CGRectMake(0.0, 0.0, 106.0, 33.0);
    CGRect logo_net = CGRectMake(126.0, 0.0, 51.0, 33.0);
    CGRect logo_linx = CGRectMake(210.0, 0.0, 126.0, 31.0);
    
    CGImageRef image_rezende = CGImageCreateWithImageInRect([logos CGImage], logo_rezende);
    CGImageRef image_net = CGImageCreateWithImageInRect([logos CGImage], logo_net);
    CGImageRef image_linx = CGImageCreateWithImageInRect([logos CGImage], logo_linx);
    
    _logoRezende.image = _logoRezende_2.image = [UIImage imageWithCGImage:image_rezende];
    _logoNet4biz.image = [UIImage imageWithCGImage:image_net];
    _logoLinx.image = [UIImage imageWithCGImage:image_linx];
    
//    [_logoLinx init:[UIImage imageWithCGImage:image_linx]];
    
    CGImageRelease(image_rezende);
    CGImageRelease(image_net);
    CGImageRelease(image_linx);
    
    
    
    //[self performSelector:@selector(hideSplash) withObject:self afterDelay:1.0];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    rezBrowserViewController *browser = segue.destinationViewController;
    
    if([[segue identifier] isEqualToString:@"doLogin"]){
        browser.username = _username.text;
        browser.password = _password.text;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:_username.text forKey:@"username"];
        [prefs setObject:_password.text forKey:@"password"];
        
        _username.text = @"Endereço de e-mail";
        _password.text = @"Palavra-chave";
        
    }
}

- (void) hideSplash {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    _logosys.center = CGPointMake(_logosys.center.x, _logosys.center.y - 150);
    
    _username.alpha = 1;
    _password.alpha = 1;
    _submit.alpha = 1;
    
    [UIView commitAnimations];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    [self animatedTextField: textField up:YES];
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [self animatedTextField:textField up:NO];
}

-(void)animatedTextField: (UITextField *) textField up: (BOOL) up {
    
//    const int movementDistance = 80;
//    const float movementDuration = 0.3f;
//    
//    int movement = (up ? -movementDistance : movementDistance);
//    [UIView beginAnimations:@"anim" context:nil];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:movementDuration];
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    [UIView commitAnimations];
}


- (void) aviso: (NSString *)tipo withMessageOrNil:(NSString *)mensagem {
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:tipo
                                                     message:mensagem
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alerta show];
}


@end







