//
//  MentionTests.m
//  JSONHipChat
//
//  Created by Son Hong Le on 8/19/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Mention.h"

@interface MentionTests : XCTestCase

@end

@implementation MentionTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsASCII64{
    unichar unicharInput = 64; // "@"
    BOOL isASCII64 = [Mention isASCII64:unicharInput];

    BOOL expectedIsASCII64 = YES;
    XCTAssertEqual(expectedIsASCII64, isASCII64, @"The validation of ascii did not match the expected validation");
}

- (void)testIsNonWordCharacter{
    unichar unicharInput = 33; // "!"
    BOOL isNonWordCharacter = [Mention isNonWordCharacter:unicharInput];
    
    BOOL expectedNonWordCharacter = YES;
    XCTAssertEqual(expectedNonWordCharacter, isNonWordCharacter, @"The validation of a non work character did not match the expected validation");
}

@end
