//
//  PassengerVC.h
//  payride
//
//  Created by Kale, Abhijit Vijay on 11/8/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import <AWSCore/AWSCore.h>
#import <AWSCognito/AWSCognito.h>
#import <AWSDynamoDB/AWSDynamoDB.h>

@interface PassengerVC : UIViewController <UITextFieldDelegate>

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;

@property (strong, nonatomic) IBOutlet UITextField *PRusername;
@property (strong, nonatomic) IBOutlet UITextField *PRemail;
@property (strong, nonatomic) IBOutlet UITextField *PRpassword;
@property (strong, nonatomic) IBOutlet UITextField *PLemail;
@property (strong, nonatomic) IBOutlet UITextField *PLpassword;
- (IBAction)Pregister:(UIButton *)sender;
- (IBAction)Plogin:(UIButton *)sender;

@end
