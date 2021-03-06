//
//  ViewController.m
//  YandexOAuthTest
//
//  Created by Vitaly Evtushenko on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    YandexOauthViewController *cntrl = [[YandexOauthViewController alloc] init];
    cntrl.delegate = self;
    [self.navigationController presentModalViewController:cntrl animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)yandexOauthViewController:(YandexOauthViewController *)controller 
         succesfullLoginWithToken:(NSString *)token
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Авторизация удалась" 
                                                    message:[NSString stringWithFormat:@"Токен %@",token]                                                    
                                                   delegate:nil 
                                          cancelButtonTitle:@"Ok" 
                                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)yandexOauthViewControllerDidCancelled:(YandexOauthViewController *)controller
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Авторизацию отменили" 
                                                    message:@"Очень жаль"                                                    
                                                   delegate:nil 
                                          cancelButtonTitle:@"Ok" 
                                          otherButtonTitles:nil];
    
    [alert show];
}

@end
