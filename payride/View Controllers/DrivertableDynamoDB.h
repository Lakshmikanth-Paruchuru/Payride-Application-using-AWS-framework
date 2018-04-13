//
//  DrivertableDynamoDB.h
//  payride
//
//  Created by Paruchuru, Lakshmikanth on 11/29/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>

@interface DrivertableDynamoDB : AWSDynamoDBObjectModel <AWSDynamoDBModeling>
    @property (nonatomic, strong) NSString *demailid;
    @property (nonatomic, strong) NSString *username;
    @property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *mobile;
    
    @end

