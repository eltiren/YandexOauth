//
//  YandexOauthViewController.h
//  Fotki Plus
//
//  Created by Vitaly Evtushenko on 10/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define URL_SCHEME @"iostestapp"
#define CLIENT_ID @"6ef1c6dc6f134a2daa67cc905e5c1a3d"

@class YandexOauthViewController;

@protocol YandexOauthViewControllerDelegate <NSObject>

- (void)yandexOauthViewController:(YandexOauthViewController*)controller succesfullLoginWithToken:(NSString*)token;

@end

@interface YandexOauthViewController : UIViewController <UIWebViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *webView;
@property (assign, nonatomic) id<YandexOauthViewControllerDelegate> delegate;

- (IBAction)reloadAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
