//
//  AppDelegate.h
//  payride
//
//  Created by Kale, Abhijit Vijay on 11/8/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

