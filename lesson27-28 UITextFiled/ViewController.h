//
//  ViewController.h
//  lesson27-28 UITextFiled
//
//  Created by Anatoly Ryavkin on 16/05/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *viewEmpty;

@property (weak, nonatomic) IBOutlet UIView *areaInput;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *familyNameField;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *mailField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYAtAreaImputConstraint;

@property NSString*stringTooShortStory;

-(NSString*)stringOldNumberTel: (NSString*)textFieldString stringNewNumber: (NSString*)string rangeInput: (NSRange)range;
-(NSString*)stringOldName: (NSString*)textFieldString stringNewName: (NSString*)string rangeInput: (NSRange)range;
-(NSString*)stringOldAge: (NSString*)textFieldString stringNewAge: (NSString*)string rangeInput: (NSRange)range;
-(NSString*)stringOldEmail: (NSString*)textFieldString stringNewEmail:(NSString*)string rangeInput:(NSRange)range;


@end

