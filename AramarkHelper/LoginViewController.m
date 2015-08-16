//
//  LoginViewController.m
//  AramarkHelper
//
//  Created by Melissa Thai on 8/6/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

{
    NSMutableData *_responseData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _responseData = [[NSMutableData alloc] init];
    self.passwordTextField.secureTextEntry = YES;
}

- (IBAction)loginButtonPressed:(id)sender {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://71.227.191.189:5000/"]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    request.HTTPMethod = @"POST";
    
    NSDictionary *loginCredentials = @{
                                       @"email" : self.emailTextField.text,
                                       @"password" : self.passwordTextField.text
                                       };
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:loginCredentials options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"data: %@", dataString);
        
        NSDictionary* dbDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        NSNumber *db = dbDictionary[@"STUDENT"];
        NSLog(@"DB: %@", db);
        
        [self navigateToTabBarControllerWithDbAmount:[db doubleValue]];
    }];
    [dataTask resume];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)navigateToTabBarControllerWithDbAmount:(double)dbAmount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        MainTabBarController * tabBarController = (MainTabBarController *) [storyboard instantiateViewControllerWithIdentifier:@"TabBarControllerIdentifier"];
        tabBarController.dbAmount = dbAmount;
        tabBarController.selectedIndex = 0;
        [self presentViewController:tabBarController animated:YES completion:nil];
    });
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
