//
//  Mentions.h
//  JSONHipChat
//
//  Created by Sonny on 8/17/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mention : NSObject

#pragma mark - Properties
@property (nonatomic, copy) NSString *userName;

#pragma mark - Functions
// Validate a charater is "@"
+ (BOOL)isASCII64:(unichar)ascii;

// Validate a character is a non-word character
+ (BOOL)isNonWordCharacter:(unichar)ascii;

@end
