//
//  Mentions.m
//  JSONHipChat
//
//  Created by Sonny on 8/17/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import "Mention.h"

@implementation Mention

#pragma mark - Functions
/**
 *   @brief  validate a charater is "@"
 *
 *   @input  a ASCII
 *
 *   @return YES if it's "@", otherwise, return NO
 *
 */
+ (BOOL)isASCII64:(unichar)ascii{
    // ascii of "@" is 64
    if (ascii == 64) {
        return YES;
    }else{
        return NO;
    }
}
/**
 *   @brief  Validate a character is a non-word character
 *
 *   @input  a ASCII
 *
 *   @return NO if it's a-z, A-Z, 0-9, otherwise, return YES
 *
 */
+ (BOOL)isNonWordCharacter:(unichar)ascii{
    
    // character from "0" to "9"
    if (ascii >= 48 && ascii <= 57) {
        return  NO;
    }
    
    // character from "A" to "Z"
    if (ascii >= 65 && ascii <= 90) {
        return  NO;
    }
    
    // character from "a" to "z"
    if (ascii >= 97 && ascii <= 122) {
        return  NO;
    }
    
    return YES;
}

@end
