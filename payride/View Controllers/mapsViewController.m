//
//  mapsViewController.m
//  payride
//
//  Created by Kale, Abhijit Vijay on 12/12/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "mapsViewController.h"

@interface mapsViewController ()

@end

@implementation mapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (void)openScheme:(NSString *)scheme {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    [application openURL:URL options:@{} completionHandler:nil];
}
- (IBAction)cost:(id)sender {
    NSString *input = _miles.text;
    long int temp = [input integerValue];
    long int mul = 0.80 * temp;
    char dollar = '$';
    NSString *aString = [NSString stringWithFormat:@"%c %ld",dollar, mul];
    _labelcost.text = aString;
    
}

- (IBAction)direction:(id)sender {
   
  [self openScheme:@"https://www.google.com/maps/@42.585444,13.007813,6z"];
    
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
