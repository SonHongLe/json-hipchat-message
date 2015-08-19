//
//  Emoticon.m
//  JSONHipChat
//
//  Created by Sonny on 8/17/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import "Emoticon.h"

@implementation Emoticon

#pragma mark - Functions
/**
 *   @brief  Validate a character is a left parenthesis "("
 *
 *   @input  a ASCII
 *
 *   @return YES if it's a left parenthesis, otherwise it returns NO
 *
 */
+ (BOOL)isLeftParenthesis:(unichar)ascii{
    
    // ascii of "(" is 40
    if (ascii == 40) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *   @brief  Validate a character is a right parenthesis ")"
 *
 *   @input  a ASCII
 *
 *   @return YES if it's a right parenthesis, otherwise it returns NO
 *
 */
+ (BOOL)isRightParenthesis:(unichar)ascii{
    
    // ascii of ")" is 41
    if (ascii == 41) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *   @brief  Validate a length of emoticon string
 *
 *   @input  emoticon string
 *
 *   @return YES if 0< length of string <= 15, otherwise it returns NO
 *
 */
+ (BOOL)isValidLength:(NSString *)emoticon{
    
    // A valid length is 1 to 15
    if (emoticon.length > 0 && emoticon.length <= 15) {
        return YES;
    }else{
        return NO;
    }
}

@end
