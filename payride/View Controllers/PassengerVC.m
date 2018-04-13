//
//  PassengerVC.m
//  payride
//
//  Created by Kale, Abhijit Vijay on 11/8/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "PassengerVC.h"
#import "PassengertableDynamoDB.h"
#import "DrivertableDynamoDB.h"
#import "PassengerLoginVC.h"
//#import "PassengerWelcome.h"

@interface PassengerVC ()
{
AWSDynamoDBObjectMapper *_dynamoDBObjectMapper;
    
}
@end

@implementation PassengerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
                                                          initWithRegionType:AWSRegionUSEast1
                                                          identityPoolId:@"us-east-1:0a51d4c4-0a1a-4498-a795-7cb4d32aa42e"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    //_dynamoDBObjectMapper = [AWSDynamoDBObjectMapper defaultDynamoDBObjectMapper];
    
    
    //[self scanDynamoDBContents];
    
    NSString *docsDir1;
    NSArray *dirPaths1;
    
    //Get the directory #Abhijit
    dirPaths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir1 = dirPaths1[0];
    
    
    
    //Build the path to keep the database #Abhijit
    _databasePath = [[NSString alloc] initWithString:[docsDir1 stringByAppendingPathComponent:@"myPassengers.db"] ];
    NSFileManager *filemgr1 = [NSFileManager defaultManager];
    if([filemgr1 fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath1 = [_databasePath UTF8String];
        if(sqlite3_open(dbpath1, &_DB) == SQLITE_OK)
        {
            char *errorMessage1;
            const char *sql_statement1 = "CREATE TABLE IF NOT EXISTS passengers (PUSERNAME TEXT, PPASSWORD TEXT, EMAIL TEXT PRIMARY KEY)";
            if(sqlite3_exec(_DB, sql_statement1, NULL, NULL, &errorMessage1) != SQLITE_OK)
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
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)Pregister:(UIButton *)sender {
    
    sqlite3_stmt *statement;
    const char *dbpath1 = [_databasePath UTF8String];
    if(sqlite3_open(dbpath1, &_DB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO passengers (PUSERNAME, PPASSWORD, EMAIL) VALUES (\"%@\", \"%@\", \"%@\")", _PRusername.text, _PRpassword.text, _PRemail.text];
        const char *insert_statement = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(_DB, insert_statement, -1, &statement, NULL);
        if(sqlite3_step(statement) == SQLITE_DONE)
        {
           
            if([self.PRusername.text isEqualToString:@""]||[self.PRpassword.text isEqualToString:@""]||[self.PRemail.text isEqualToString:@""])
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please fill all the fields" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            //else{

            // }
            
        }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to add Passenger" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(_DB);
    }
    PassengertableDynamoDB *gWord1 = [PassengertableDynamoDB new];
    gWord1.username = _PRusername.text;
    gWord1.password =_PRpassword.text;
    gWord1.pemailid= _PRemail.text;
    gWord1.reqdriver = @"";
    [[_dynamoDBObjectMapper save:gWord1]
     continueWithBlock:^id(AWSTask *task) {
         if (task.error) {
             NSLog(@"The request failed. Error: [%@]", task.error);
         } else {
             //Do something with task.result or perform other operations.
         }
         return nil;
     }];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Passenger added to Database" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    _PRusername.text = @"";
    _PRpassword.text = @"";
    _PRemail.text = @"";
    
    
}



- (IBAction)Plogin:(UIButton *)sender {
    
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_DB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM passengers WHERE EMAIL = \"%@\" AND PPassword = \"%@\"", _PLemail.text,_PLpassword.text];
        const char *query_statement = [querySQL UTF8String];
        if(sqlite3_prepare_v2(_DB, query_statement, -1, &statement, NULL)== SQLITE_OK){
            if(sqlite3_step(statement)==SQLITE_ROW)
            {
                
                
              /*  NSString *passwordField = [[NSString alloc]initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                if(_PLemail.text == passwordField)
                { */
                
                if([self.PLemail.text isEqualToString:@""]||[self.PLpassword.text isEqualToString:@""])
                {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please fill all the fields" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:ok];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
                else{
                   /* UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Login Successful" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:ok];
                    [self presentViewController:alert animated:YES completion:nil]; */
                    

                    [self performSegueWithIdentifier:@"Passenger2PassengerWelcome" sender:self];
                }
                
                
               }
                
                
                else
                {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Incorrect Email or Password" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:ok];
                    [self presentViewController:alert animated:YES completion:nil];
                    _PLpassword.text=@"";
                }
                sqlite3_finalize(statement);
                
            }
            else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to search the database" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            //sqlite3_finalize(statement);
            sqlite3_close(_DB);
        }
        
    }

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Passenger2PassengerWelcome"]){
        
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        PassengerLoginVC *controller = (PassengerLoginVC *)navController.topViewController;
        controller.dataString =  _PRemail.text;
        
    }
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)unwindSegue
{
    
}

@end
