//
//  PassengerLoginVC.h
//  payride
//
//  Created by Paruchuru, Lakshmikanth on 11/9/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PassengerVC.h"
#import "DrivertableDynamoDB.h"
@interface PassengerLoginVC : UITableViewController
{
    sqlite3 * DB;
    
    NSMutableArray* _locationhistory;
}
@property (nonatomic, assign) BOOL isSomethingEnabled;
@property (nonatomic, copy) NSString* dataString;
- (IBAction)refresh:(id)sender;

- (IBAction)logout:(id)sender;
- (IBAction)maps:(id)sender;


@end

