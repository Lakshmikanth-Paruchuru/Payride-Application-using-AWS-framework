//
//  DrivertableDynamoDB.m
//  payride
//
//  Created by Paruchuru, Lakshmikanth on 11/29/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "DrivertableDynamoDB.h"


@implementation DrivertableDynamoDB
    
+ (NSString *)dynamoDBTableName {
    return @"drivertable";
}

+ (NSString *)hashKeyAttribute {
    return @"demailid";
}


    @end

