//
//  YandexOauthViewController.m
//  Fotki Plus
//
//  Created by Vitaly Evtushenko on 10/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "YandexOauthViewController.h"

@implementation YandexOauthViewController

@synthesize webView;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self reloadAction:self];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)reloadAction:(id)sender 
{
    NSString *urlString = [NSString stringWithFormat:@"https://oauth.yandex.ru/authorize?response_type=token&client_id=%@&display=popup",CLIENT_ID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:urlRequest];
}

- (IBAction)cancelAction:(id)sender 
{
    if ([delegate respondsToSelector:@selector(yandexOauthViewControllerDidCancelled:)])
    {
        [delegate yandexOauthViewControllerDidCancelled:self];
    }
}

#pragma mark - UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //Получаем URL
    NSURL *url = [request URL];
    
    //Проверяем на соответствие пользовательской URL-схеме
    if ([url.scheme isEqualToString:URL_SCHEME])
    {
        //убираем индикатор сетевой активности
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = NO;
        
        //разбираем URL на отдельные элементы
        //наш токен будет в массиве arr под индексом 2
        NSArray *arr = [[url description] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#=&"]];
        
        //говорим делегату об успешной авторизации и передаем токен
        if ([delegate respondsToSelector:@selector(yandexOauthViewController:succesfullLoginWithToken:)])
        {
            [delegate yandexOauthViewController:self succesfullLoginWithToken:[arr objectAtIndex:2]];
        }
        
        //запрещаем UIWebView открывать URL
        return NO;
    }
    
    //разрешаем UIWebView переход по URL
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

@end
