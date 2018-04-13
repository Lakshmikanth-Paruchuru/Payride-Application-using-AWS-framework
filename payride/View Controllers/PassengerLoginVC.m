//
//  PassengerLoginVC.m
//  payride
//
//  Created by Paruchuru, Lakshmikanth on 11/9/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "PassengerLoginVC.h"
//#import "DriverVC.h"
#import "ViewDrivers.h"
#import "PassengertableDynamoDB.h"
@interface PassengerLoginVC ()
//-(void) openDB;
{
    AWSDynamoDBObjectMapper *_dynamoDBObjectMapper;
    
}
@end

@implementation PassengerLoginVC
{
    NSArray *loc;
    NSString * fiepath;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
 /*   sqlite3_stmt *statement;
    NSString *selectSQL =@"SELECT LOCATION FROM users";
    const char *insert_stmt = [selectSQL UTF8String];
    if (sqlite3_prepare(, insert_stmt, -1, &statement, NULL)) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            {
                
            }
        }
    }
    */
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
                                                          initWithRegionType:AWSRegionUSEast1
                                                          identityPoolId:@"us-east-1:0a51d4c4-0a1a-4498-a795-7cb4d32aa42e"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    _dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    _locationhistory = [[NSMutableArray alloc] init];
    [_locationhistory removeAllObjects];
    AWSDynamoDBScanExpression *scanExpression = [AWSDynamoDBScanExpression new];
    //scanExpression.projectionExpression = @"username, location ";
    [[_dynamoDBObjectMapper scan:[DrivertableDynamoDB class]
                      expression:scanExpression]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         } else {
             AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
             for (DrivertableDynamoDB *dbGuessword in paginatedOutput.items) {
                 //Do something with guessword object.
                 [_locationhistory addObject:dbGuessword];
                 
                 
             }
             
         }
         
         return nil;
         
     }];
    
    
    //[self scanDynamoDBContents];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return _locationhistory.count;
    //return  loc.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locCell" forIndexPath:indexPath];
    
    if([_locationhistory count] > 0 && [_locationhistory count] > indexPath.row){
    DrivertableDynamoDB* guesswordObj = [_locationhistory objectAtIndex:indexPath.row];
        cell.textLabel.text =  [NSString stringWithFormat:@"%@:  %@:  %@",  guesswordObj.username, guesswordObj.location, guesswordObj.mobile ];
    //cell.textLabel.text = [_locationhistory objectAtIndex:indexPath.row];
    }
    else {
        [self.tableView reloadData];
    }
    return cell;
    
    //static NSString *simpleTableIdentifier = @"locCell";
    //if (cell==nil) {
        //cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//}
     //Configure the cell...
    //cell.textLabel.text = [loc objectAtIndex:indexPath.row];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DrivertableDynamoDB* driver = [_locationhistory objectAtIndex:indexPath.row];
    PassengertableDynamoDB *gterm = [PassengertableDynamoDB new];
    
    gterm.pemailid = _dataString;
    gterm.reqdriver = driver.username;
    [[_dynamoDBObjectMapper save:gterm]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         } else {
             //Do something with task.result or perform other operations.
         }
         return nil;
     }];
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Locations2Drivers"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ViewDrivers *destViewController = segue.destinationViewController;
        destViewController.driverName = [loc objectAtIndex:indexPath.row];
        destViewController.title=destViewController.driverName;
    }
    
}

- (void) scanDynamoDBContents {
    
}

- (IBAction)refresh:(id)sender {
    
    [self.tableView reloadData];
}

- (IBAction)logout:(id)sender {
    [self performSegueWithIdentifier:@"unwindToLoginID" sender:self];
}

- (IBAction)maps:(id)sender {
    
    [self performSegueWithIdentifier:@"2maps" sender:sender];
}

@end
