//
//  DriverVC.h
//  payride
//
//  Created by Kale, Abhijit Vijay on 11/8/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <AWSCore/AWSCore.h>
#import <AWSCognito/AWSCognito.h>
#import <AWSDynamoDB/AWSDynamoDB.h>


@interface DriverVC : UIViewController <UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate>

    //@property (strong, nonatomic) IBOutlet UIPickerView *pick;
    //@property(strong, nonatomic) NSString *locations;
    @property (weak, nonatomic) IBOutlet UITextField *LocationTextField;
    @property(strong, nonatomic) NSString *databasePath;
    @property(nonatomic) sqlite3 *DB;
    @property (strong, nonatomic) IBOutlet UITextField *Rusername;
    @property (strong, nonatomic) IBOutlet UITextField *Rpassword;
    @property (strong, nonatomic) IBOutlet UITextField *email;
    @property (strong, nonatomic) IBOutlet UITextField *Lusername;
    @property (strong, nonatomic) IBOutlet UITextField *Lpassword;
    - (IBAction)register:(UIButton *)sender;
    - (IBAction)login:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *mobile;

@end


