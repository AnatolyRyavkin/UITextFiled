//
//  ViewController.m
//  lesson27-28 UITextFiled
//
//  Created by Anatoly Ryavkin on 16/05/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stringTooShortStory=[[NSString alloc]init];

}

#pragma mark -input Email

-(NSString*)stringOldEmail: (NSString*)textFieldString stringNewEmail:(NSString*)string rangeInput:(NSRange)range{

    int checCountDogInString = 0;
    for(int i = 0; i<string.length;i++){
        unichar h=[string characterAtIndex:i];
        if([[NSString stringWithFormat:@"%c",h] isEqualToString:@"@"])
            checCountDogInString++;
    }

    int checCountDogInText = 0;
    for(int i = 0; i<textFieldString.length;i++){
        unichar h=[textFieldString characterAtIndex:i];
        if([[NSString stringWithFormat:@"%c",h] isEqualToString:@"@"])
            checCountDogInText++;
    }

    if((checCountDogInText==0 && checCountDogInString<=1) || (checCountDogInText==1 && checCountDogInString==0 )){
        NSMutableString*stringTemp=[[NSMutableString alloc]initWithString:textFieldString];
         [stringTemp replaceCharactersInRange:range withString:string];
        return stringTemp;
    }else{
         return textFieldString;
    }
}


#pragma mark -inputAge

-(NSString*)stringOldAge: (NSString*)textFieldString stringNewAge: (NSString*)string rangeInput: (NSRange)range{

    NSMutableString*stringTemp=[[NSMutableString alloc]initWithString:textFieldString];

    NSMutableCharacterSet *setControl = [NSMutableCharacterSet decimalDigitCharacterSet];
    [setControl invert];

    NSArray*arrayCheckAtNumber=[string componentsSeparatedByCharactersInSet:setControl];

    if(arrayCheckAtNumber.count==1){
        [stringTemp replaceCharactersInRange:range withString:string];
        return stringTemp;
    }else{
        return textFieldString;
    }
}


#pragma mark -inputName&NameFamily

-(NSString*)stringOldName: (NSString*)textFieldString stringNewName: (NSString*)string rangeInput: (NSRange)range{

    NSMutableString*stringTemp=[[NSMutableString alloc]initWithString:textFieldString];

    NSMutableCharacterSet *setControl = [NSMutableCharacterSet letterCharacterSet];
    [setControl invert];

    NSArray*arrayCheckAtNumber=[string componentsSeparatedByCharactersInSet:setControl];

    if(arrayCheckAtNumber.count==1){
        [stringTemp replaceCharactersInRange:range withString:string];
         return stringTemp;
    }else{
        return textFieldString;
    }
}


#pragma mark-inputNumberTelephone

-(NSString*)stringOldNumberTel: (NSString*)textFieldString stringNewNumber: (NSString*)string rangeInput: (NSRange)range{
    NSMutableString*stringTemp=[[NSMutableString alloc]initWithString:textFieldString];
    NSMutableCharacterSet *setControl = [NSMutableCharacterSet decimalDigitCharacterSet];
    [setControl invert];
    NSArray*arrayCheckAtNumber=[string componentsSeparatedByCharactersInSet:setControl];
    if(arrayCheckAtNumber.count==1){
        [stringTemp replaceCharactersInRange:range withString:string];
    }else{
        return textFieldString;
    }
    NSMutableArray*arrayChar=[[NSMutableArray alloc]init];
    for (int i = 0; i < [stringTemp length]; i++) {
        NSString *ch = [stringTemp substringWithRange:NSMakeRange(i, 1)];
        if(![ch isEqualToString:@"-"] && ![ch isEqualToString:@"("] && ![ch isEqualToString:@")"] && ![ch isEqualToString:@"+"])
        [arrayChar addObject:ch];
    }

    NSInteger count=arrayChar.count;

    if(count>2){
        [arrayChar insertObject:@"-" atIndex:count-2];
    }
    if(count>4){
        [arrayChar insertObject:@"-" atIndex:count-4];
    }
    if(count>7&&count<=10){
         [arrayChar insertObject:@")" atIndex:count-7];
         [arrayChar insertObject:@"(" atIndex:0];

    }
    if(count>10){
        [arrayChar insertObject:@")" atIndex:count-7];
        [arrayChar insertObject:@"(" atIndex:count-10];
        [arrayChar insertObject:@"+" atIndex:0];
    }
    NSString*stringResult=[arrayChar componentsJoinedByString:@""];
    return stringResult;
}

#pragma mark- ChangeConstraints

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    [self.areaInput removeConstraint:self.centerYAtAreaImputConstraint];
    self.centerYAtAreaImputConstraint.active=NO;

    CGFloat constant =(self.view.bounds.size.height<self.view.bounds.size.width)? -textField.frame.origin.y+100 : 0;

    self.centerYAtAreaImputConstraint= [NSLayoutConstraint constraintWithItem:self.areaInput attribute: NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.viewEmpty attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];

    self.centerYAtAreaImputConstraint.active=YES;
    [self.inputView addConstraint:self.centerYAtAreaImputConstraint];
    [self.areaInput updateConstraints];

    return YES;
}

#pragma mark= Replace 8 at +7

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag==6){
        NSMutableString*stringTemp= [NSMutableString stringWithString:textField.text];
        if ( stringTemp.length==16){
            char ch=[stringTemp characterAtIndex:1];
            NSString*str=[NSString stringWithFormat:@"%c",ch];
            if([str isEqualToString:@"8"]){
                [stringTemp replaceCharactersInRange:NSMakeRange(1,1) withString:@"7"];
                textField.text=stringTemp;
            }
        }
        if(stringTemp.length<5){
            self.stringTooShortStory=textField.text;
            textField.text=@"Too short number!!!";
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag==6 && [textField.text isEqualToString:@"Too short number!!!"]){
        textField.text=self.stringTooShortStory;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    switch (textField.tag) {
        case 1:
            if(textField.text.length+string.length<20 && ![string isEqualToString:@""]){
                textField.text = [self stringOldName:textField.text stringNewName:string rangeInput:range];
                return NO;
            }else if([string isEqualToString:@""]){
                return YES;
            }
            break;
        case 2:
            if(textField.text.length+string.length<20 && ![string isEqualToString:@""]){
                textField.text = [self stringOldName:textField.text stringNewName:string rangeInput:range];
                return NO;
            }else if([string isEqualToString:@""]){
                return YES;
            }

            break;
        case 3:
            if(textField.text.length+string.length<20 || [string isEqualToString:@""])
                return YES;

            break;
        case 4:
            if(textField.text.length+string.length<20 || [string isEqualToString:@""])
                return YES;

            break;
        case 5:
            if(textField.text.length+string.length<3 && ![string isEqualToString:@""]){
                textField.text = [self stringOldAge:textField.text stringNewAge:string rangeInput:range];
                return NO;
            }else if([string isEqualToString:@""]){
                return YES;
            }

            break;
        case 6:
            if(textField.text.length+string.length<19 && ![string isEqualToString:@""]){
                textField.text = [self stringOldNumberTel:textField.text stringNewNumber:string rangeInput:range];
                return NO;
            }else if([string isEqualToString:@""]){
                return YES;
            }

            break;
        case 7:
            if(textField.text.length+string.length<20 && ![string isEqualToString:@""]){
                textField.text = [self stringOldEmail:textField.text stringNewEmail:string rangeInput:range];
                return NO;
            }else if([string isEqualToString:@""]){
                return YES;
            }

            break;

        default:
            return NO;
            break;
    }
    return NO;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSArray*array=[NSArray arrayWithObjects:self.nameField, self.familyNameField, self.loginField, self.passwordField, self.ageField, self.phoneNumField, self.mailField, nil];
    if(textField.tag==7){
        [textField resignFirstResponder];
    }else{
        [[array objectAtIndex:textField.tag] becomeFirstResponder];
    }
    return YES;
}


@end
