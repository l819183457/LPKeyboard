//
//  LPAutoKeyboardTextField.m
//  LPKeyboard
//
//  Created by pill on 2018/12/7.
//  Copyright © 2018 LP. All rights reserved.
//

#import "LPAutoKeyboardTextField.h"

#import "LPKeyboardView.h"
#import "UITextField+Extension.h"

@interface LPAutoKeyboardTextField ()<LPKeyboardViewDelegate,UITextFieldDelegate>

@end

@implementation LPAutoKeyboardTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _textMaxLength = INT_MAX;
        self.delegate = self;
        LPKeyboardView * view1 = [[LPKeyboardView alloc]init];
        view1.keyboardType = 0;
        view1.delegate = self;
        self.inputView = view1;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        LPKeyboardView * view1 = [[LPKeyboardView alloc]init];
        view1.keyboardType = 1;
        view1.delegate = self;
        self.inputView = view1;
    }
    return self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.text.length >= _textMaxLength) {
            self.text = [textField.text substringToIndex:_textMaxLength];
            return NO;
        }
    }
    return YES;
}
-(void)keyboardView:(id)target changeKeyboard:(nullable NSString * )str atKeyboard:( NSInteger )type
{
    
}
-(void)keyboardView:(id)target inputStr:(nonnull NSString *)str atKeyboard:( NSInteger )type
{
   [self insertText:str];
    
}
-(void)keyboardView:(id)target deleteKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type
{
    [self deleteBackward];
    
}
-(void)keyboardView:(id)target doneKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type{
    [self resignFirstResponder];
}

@end
