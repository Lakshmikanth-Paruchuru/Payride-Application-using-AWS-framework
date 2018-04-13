//
//  ViewDrivers.m
//  payride
//
//  Created by Paruchuru, Lakshmikanth on 11/11/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "ViewDrivers.h"
#import "PThankYouViewController.h"

@interface ViewDrivers ()

@end

@implementation ViewDrivers{
    NSArray *Almeda;
    NSArray *Baytown;
    NSArray *Highlands;
    NSArray *Pasadena;
    NSArray *texasCity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Almeda = [NSArray arrayWithObjects:@"John Doe",@"Cooper",@"Ronny",@"Mike",nil];
    Baytown = [NSArray arrayWithObjects:@"Pablo",@"Nikole",@"Smith",nil];
    Highlands = [NSArray arrayWithObjects:@"Tyson",@"Jane",@"David Sanchez",nil];
    Pasadena = [NSArray arrayWithObjects:@"Benson",@"AJ",@"Rick",nil];
    texasCity = [NSArray arrayWithObjects:@"Dalton",@"Fredy",nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    if ([_driverName isEqualToString:@"Almeda"]) {
        return [Almeda count];
    } else if ([_driverName isEqualToString:@"Baytown"]) {
        return [Baytown count];
    } else if ([_driverName isEqualToString:@"Highlands"]) {
        return [Highlands count];
    } else if ([_driverName isEqualToString:@"Pasadena"]) {
        return [Pasadena count];
    } else  if ([_driverName isEqualToString:@"Texas City"]) {
        return [texasCity count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *simpleTableIdentifier = @"driver2cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if ([_driverName isEqualToString:@"Almeda"]) {
        cell.textLabel.text = [Almeda objectAtIndex:indexPath.row];
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    } else if ([_driverName isEqualToString:@"Baytown"]) {
       cell.textLabel.text = [Baytown objectAtIndex:indexPath.row];
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    } else if ([_driverName isEqualToString:@"Highlands"]) {
        cell.textLabel.text = [Highlands objectAtIndex:indexPath.row];
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    } else if ([_driverName isEqualToString:@"Pasadena"]) {
        cell.textLabel.text = [Pasadena objectAtIndex:indexPath.row];
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    } else  if ([_driverName isEqualToString:@"Texas City"]) {
        cell.textLabel.text = [texasCity objectAtIndex:indexPath.row];
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    }
   
    // Configure the cell...
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toThankYou"]) {
        NSIndexPath *indexpath = (NSIndexPath *)sender;
        PThankYouViewController *displaymessage = (PThankYouViewController *)segue.destinationViewController;
 
        
 
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
} */


- (IBAction)maps:(id)sender {
}
@end
