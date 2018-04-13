//
//  PassengertableDynamoDB.h
//  payride
//
//  Created by Paruchuru, Lakshmikanth on 12/6/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface PassengertableDynamoDB : AWSDynamoDBObjectModel <AWSDynamoDBModeling>
@property (nonatomic, strong) NSString *pemailid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *reqdriver;
@end
