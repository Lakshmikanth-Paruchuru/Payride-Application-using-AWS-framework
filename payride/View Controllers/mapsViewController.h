//
//  mapsViewController.h
//  payride
//
//  Created by Kale, Abhijit Vijay on 12/12/17.
//  Copyright © 2017 Kale, Abhijit Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<MapKit/MapKit.h>
@interface mapsViewController : UIViewController <UITextFieldDelegate>

@property(strong, nonatomic) IBOutlet MKMapView *mapview;
@property (strong, nonatomic) IBOutlet MKMapView *mapviewout;
- (IBAction)cost:(id)sender;
- (IBAction)direction:(id)sender;
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *miles;
@property (strong, nonatomic) IBOutlet UILabel *labelcost;

@end
