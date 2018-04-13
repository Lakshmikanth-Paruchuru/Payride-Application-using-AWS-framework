//
//  IncomingReqTableViewController.m
//  payride
//
//  Created by Kale, Abhijit Vijay on 12/10/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "IncomingReqTableViewController.h"
#import "PassengertableDynamoDB.h"
@interface IncomingReqTableViewController ()
{
    NSArray *devices;
    
    AWSDynamoDBObjectMapper *_dynamoDBObjectMapper;
        
    
}
@end

@implementation IncomingReqTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    devices = @[@"Michael", @"Hunter", @"Lion", @"Leon"];
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
                                                          initWithRegionType:AWSRegionUSEast1
                                                          identityPoolId:@"us-east-1:0a51d4c4-0a1a-4498-a795-7cb4d32aa42e"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    _dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    _passengerhistory = [[NSMutableArray alloc] init];
    //[_passengerhistory removeAllObjects];
    AWSDynamoDBScanExpression *scanExpression = [AWSDynamoDBScanExpression new];
    //scanExpression.projectionExpression = @"username";
    [[_dynamoDBObjectMapper scan:[PassengertableDynamoDB class]
                      expression:scanExpression]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         } else {
             AWSDynamoDBPaginatedOutput *paginatedOutput = task.result;
             for (PassengertableDynamoDB *dbword in paginatedOutput.items) {
                 //Do something with guessword object.
                 [_passengerhistory addObject:dbword];
                 
                 
             }
             
         }
         
         return nil;
         
     }];
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

    return devices.count;
}



    
    //Configure the cell...
    //cell.textLabel.text = devices[indexPath.row];
    //return cell;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Incomingcell" forIndexPath:indexPath];
    if([_passengerhistory count] > 0 && [_passengerhistory count] > indexPath.row)
    {
    PassengertableDynamoDB* wordObj = [_passengerhistory objectAtIndex:indexPath.row];
    cell.textLabel.text =  [NSString stringWithFormat:@"%@:                          %@ ",  wordObj.username, wordObj.reqdriver];
    //cell.textLabel.text = [_passengerhistory objectAtIndex:indexPath.row];
    
    }
    else
    {
        [self.tableView reloadData];
    }
return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)logoutbtn:(id)sender {
    [self performSegueWithIdentifier:@"unwindtored" sender:self];
}

- (IBAction)refreshdriver:(id)sender {
     [self.tableView reloadData];
}
@end
