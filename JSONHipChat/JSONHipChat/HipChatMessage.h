//
//  HipChatMessage.h
//  JSONHipChat
//
//  Created by Sonny on 8/16/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HipChatMessage : NSObject

#pragma mark - Properties
// Array of mention
@property (nonatomic, copy) NSMutableArray  *mentions;

// Array of emoticon
@property (nonatomic, copy) NSMutableArray  *emoticons;

// Array of url and webpage title
@property (nonatomic, copy) NSMutableArray  *links;


#pragma mark - Inittialize
// Initializer of HipChatMessage object
- (id)initWithHipChatMessage:(NSString *)message;

// Get json string from HipChatMessage object
- (NSString *)getJSON;

@end
