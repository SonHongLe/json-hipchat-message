//
//  ViewController.h
//  JSONHipChat
//
//  Created by Sonny on 8/16/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HipChatViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *messageTextField;
@property (nonatomic, weak) IBOutlet UITextView *jsonTextView;

@end

