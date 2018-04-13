//
//  PassengertableDynamoDB.m
//  payride
//
//  Created by Paruchuru, Lakshmikanth on 12/6/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import "PassengertableDynamoDB.h"

@implementation PassengertableDynamoDB

+ (NSString *)dynamoDBTableName {
    return @"passengertable";
}
+ (NSString *)hashKeyAttribute {
    return @"pemailid";
}
@end
