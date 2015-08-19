//
//  Emoticon.h
//  JSONHipChat
//
//  Created by Sonny on 8/17/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emoticon : NSObject

#pragma mark - Properties
@property (nonatomic, copy) NSString *emoticon;

#pragma mark - Functions
// Validate a character is a left parenthesis
+ (BOOL)isLeftParenthesis:(unichar)ascii;

// Validate a character is a right parenthesis
+ (BOOL)isRightParenthesis:(unichar)ascii;

// Validate a length of emoticon string
+ (BOOL)isValidLength:(NSString *)emoticon;

@end
