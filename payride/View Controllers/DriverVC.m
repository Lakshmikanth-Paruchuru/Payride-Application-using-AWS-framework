//
//  DriverVC.m
//  payride
//
//  Created by Kale, Abhijit Vijay on 11/8/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "DriverVC.h"
#import "PassengerLoginVC.h"
#import "DrivertableDynamoDB.h"

@interface DriverVC ()
{
    NSArray *_pickerData;
    NSInteger row;
     AWSDynamoDBObjectMapper *_dynamoDBObjectMapper;
    
}
@end

@implementation DriverVC

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        UINavigationController *navcontroller = (UINavigationController *) segue.destinationViewController;
        PassengerLoginVC *controller = (PassengerLoginVC *)navcontroller.topViewController;
        controller.isSomethingEnabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Abhijit
    //_pickerData = @[@"Location",@"Baytown", @"Dickinson", @"Clear Lake", @"Webster", @"League City"];
    //self.pick.dataSource = self;
    //self.pick.delegate = self;
    
    
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
                                                          initWithRegionType:AWSRegionUSEast1
                                                          identityPoolId:@"us-east-1:0a51d4c4-0a1a-4498-a795-7cb4d32aa42e"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    _dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];

    
    NSString *docsDir;
    NSArray *dirPaths;
    
    //Get the directory #Abhijit
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    //Build the path to keep the database #Abhijit
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"myUsers.db"] ];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if(sqlite3_open(dbpath, &_DB) == SQLITE_OK)
        {
            char *errorMessage;
            const char *sql_statement = "CREATE TABLE IF NOT EXISTS users (RUSERNAME TEXT, RPASSWORD TEXT, LOCATION TEXT, EMAIL TEXT PRIMARY KEY)";
            if(sqlite3_exec(_DB, sql_statement, NULL, NULL, &errorMessage) != SQLITE_OK)
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to create table" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            sqlite3_close(_DB);
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to open table" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
/*-(void) showUIAlertWithMessage: (NSString*)message anditle:(NSString*) title{UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// The number of columns of data
- (long)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (long)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
    //_locations = [_pickerData objectAtIndex:row];
    //_locations = _pickerData[row];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)register:(UIButton *)sender {
    
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_DB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO users (RUSERNAME, RPASSWORD, LOCATION, EMAIL) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", _Rusername.text, _Rpassword.text, _LocationTextField.text, _email.text];
        const char *insert_statement = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(_DB, insert_statement, -1, &statement, NULL);
        if(sqlite3_step(statement) == SQLITE_DONE)
        {
            if([self.Rusername.text isEqualToString:@""]||[self.Rpassword.text isEqualToString:@""]||[ self.LocationTextField.text isEqualToString: @"Location"]||[self.email.text isEqualToString:@""]||[self.mobile.text isEqualToString:@""])
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please fill all the fields" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            else {
            

           DrivertableDynamoDB *gWord = [DrivertableDynamoDB new];
                gWord.username = _Rusername.text;
                gWord.password =_Rpassword.text;
                gWord.demailid= _email.text;
                gWord.location= _LocationTextField.text;
                gWord.mobile= _mobile.text;
                [[_dynamoDBObjectMapper save:gWord]
                 continueWithBlock:^id(AWSTask *task) {
                     if (task.error) {
                         NSLog(@"The request failed. Error: [%@]", task.error);
                     } else {
                         //Do something with task.result or perform other operations.
                     }
                     return nil;
                 }];

               // AWSDynamoDBPutItemInput *putItemRequest = [AWSDynamoDBPutItemInput new];
              //  AWSRequest. = @"driverTable";
            //   AWSDynamoDBAttributeValue *value = [[AWSDynamoDBAttributeValue alloc] initWithCoder:_email];
             //  [AWSRequest.item SETVAL: value forKey]
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Driver added to Database" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                _Rusername.text = @"";
                _Rpassword.text = @"";
                _email.text = @"";
                _LocationTextField.text = @"";
                _mobile.text = @"";
            }
            
        }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to add Driver" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        sqlite3_finalize(statement);
        sqlite3_close(_DB);
    }
  
}

- (IBAction)login:(UIButton *)sender {
    
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_DB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT RPASSWORD FROM users WHERE EMAIL = \"%@\" ", _Lusername.text];
        const char *query_statement = [querySQL UTF8String];
        if(sqlite3_prepare_v2(_DB, query_statement, -1, &statement, NULL)== SQLITE_OK){
            if(sqlite3_step(statement)==SQLITE_ROW)
            {
                
                
              NSString *passwordField = [[NSString alloc]initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                if(_Lpassword.text == passwordField)
                {
                    
                    
                    [self performSegueWithIdentifier:@"Driver2Incoming" sender:self];
                 /*   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Login Successful" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:ok];
                    [self presentViewController:alert animated:YES completion:nil];
                    [self performSegueWithIdentifier:@"Driver2Incoming" sender:self];  */
                }
                
                
            else
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Incorrect Email or Password" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                _Lpassword.text=@"";
            }
            sqlite3_finalize(statement);
            
        }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Driver not registered" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        //sqlite3_finalize(statement);
        sqlite3_close(_DB);
    }
    
    }
   
}

- (IBAction)unwindToRed:(UIStoryboardSegue *)unwindSegue
{
    
}


@end
