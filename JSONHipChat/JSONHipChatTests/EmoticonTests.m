//
//  EmoticonTests.m
//  JSONHipChat
//
//  Created by Son Hong Le on 8/19/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Emoticon.h"

@interface EmoticonTests : XCTestCase

@end

@implementation EmoticonTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsLeftParenthesis{
    unichar originalUnichar = 40; // "("
    BOOL isLeftParenthesis = [Emoticon isLeftParenthesis:originalUnichar];
    
    BOOL expectedIsLeftParenthesis = YES;
    XCTAssertEqual(expectedIsLeftParenthesis, isLeftParenthesis, @"The validation of left parenthesis did not match the expected validation");
}

- (void)testIsRightParenthesis{
    unichar originalUnichar = 41; // ")"
    BOOL isRightParenthesis = [Emoticon isRightParenthesis:originalUnichar];
    
    BOOL expectedIsRightParenthesis = YES;
    XCTAssertEqual(expectedIsRightParenthesis, isRightParenthesis, @"The validation of right parenthesis did not match the expected validation");
}

- (void)testIsValidLength{
    NSString *originalString = @"HipChat"; // length = 7
    BOOL lengthOfString = [Emoticon isValidLength:originalString];
    
    BOOL expectedLength = YES;
    XCTAssertEqual(expectedLength, lengthOfString, @"The validation of length of string did not match the expected validation");
}
@end
