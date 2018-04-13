//
//  IncomingReqTableViewController.h
//  payride
//
//  Created by Kale, Abhijit Vijay on 12/10/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomingReqTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
     NSMutableArray* _passengerhistory;
}
- (IBAction)logoutbtn:(id)sender;
- (IBAction)refreshdriver:(id)sender;

@end
