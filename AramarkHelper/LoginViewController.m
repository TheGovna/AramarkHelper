//
//  LoginViewController.m
//  AramarkHelper
//
//  Created by Melissa Thai on 8/6/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

{
    NSMutableData *_responseData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _responseData = [[NSMutableData alloc] init];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    }];
    [dataTask resume];
}

// MT 8/6/15: Do we really need this?
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}
@end
