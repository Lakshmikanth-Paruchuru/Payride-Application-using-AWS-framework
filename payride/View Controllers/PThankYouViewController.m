//
//  PThankYouViewController.m
//  payride
//
//  Created by Kale, Abhijit Vijay on 12/9/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "PThankYouViewController.h"

@interface PThankYouViewController ()

@end

@implementation PThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"Thank You";
    NSString *message = @"Go ahead and contact the driver.";
    NSString *oktext = @"OK";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OkButton = [UIAlertAction actionWithTitle:oktext style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:OkButton];
    [self presentViewController:alert animated:YES completion:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
