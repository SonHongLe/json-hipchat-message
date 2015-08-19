//
//  ViewController.m
//  JSONHipChat
//
//  Created by Sonny on 8/16/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import "HipChatViewController.h"
#import "HipChatMessage.h"

@interface HipChatViewController ()

@property (nonatomic, strong) HipChatMessage *hipChat;
@end

@implementation HipChatViewController

#pragma mark - Functions
- (void)convertMessageToJSON{
    NSString *message = self.messageTextField.text;
    
    self.hipChat = [[HipChatMessage alloc] initWithHipChatMessage:message];
    
    self.jsonTextView.text = [self.hipChat getJSON];
}

#pragma mark - View Controller circle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageTextField.tag = 2;
    self.messageTextField.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - UITextFieldDelegate Handlings
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.backgroundColor = [UIColor colorWithRed:251.0f/255.0f green:251.0f/255.0f blue:249.0f/255.0f alpha:1.0f];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 2) {
        [textField resignFirstResponder];

        [self convertMessageToJSON];
    }
    return YES;
}
@end
