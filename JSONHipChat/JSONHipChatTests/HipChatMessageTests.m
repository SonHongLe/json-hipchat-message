//
//  HipChatMessageTests.m
//  JSONHipChat
//
//  Created by Son Hong Le on 8/19/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "HipChatMessage.h"
#import "Mention.h"
#import "Emoticon.h"
#import "Link.h"

@interface HipChatMessageTests : XCTestCase

@end

@interface HipChatMessage (Test)

// Extract an array of mention string from a chat message
- (void)parseStringToMentions:(NSString *)message;

// Extract an array of  emoticon string from a chat message
- (void)parseStringToEmoticons:(NSString *)message;

// Extract an array of link and webpage title string from a chat message
- (void)parseStringToLinks:(NSString *)message;

// get an array of user name string from an array of mention object
- (NSMutableArray *)getUserNames:(NSMutableArray *)mentions;

// get an array of emoticon string from an array of emoticon object
- (NSMutableArray *)getEmoticons:(NSMutableArray *)emoticons;

// get an array of url and webpage title string from an array of link object
- (NSMutableArray *)getURLandTitles:(NSMutableArray *)links;

@end

@implementation HipChatMessageTests

- (void)setUp {
    [super setUp];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParseStringToMentions{
    NSString *message = @"@bob @john (success)";
 
    HipChatMessage *hipchat = [[HipChatMessage alloc] initWithHipChatMessage:message];
    [hipchat parseStringToMentions:message];
    
    NSMutableArray *mentions = [[NSMutableArray alloc] initWithCapacity:0];
    for (Mention *obj in hipchat.mentions) {
        [mentions addObject:obj.userName];
    }
    
    // Expected ouput
    NSMutableArray *expectedMentions = [[NSMutableArray alloc] init];
    [expectedMentions addObject:@"bob"];
    [expectedMentions addObject:@"john"];
    
    XCTAssertEqualObjects(expectedMentions, mentions, @"The array of mention did not match the expected mention");
  
}

- (void)testParseStringToEmoticons{
    NSString *message = @"Good morning! (megusta) (coffee)";
    
    HipChatMessage *hipchat = [[HipChatMessage alloc] initWithHipChatMessage:message];
    [hipchat parseStringToEmoticons:message];
    
    NSMutableArray *emoticons = [[NSMutableArray alloc] initWithCapacity:0];
    for (Emoticon *obj in hipchat.emoticons) {
        [emoticons addObject:obj.emoticon];
    }
    
    // Expected ouput
    NSMutableArray *expectedEmoticons = [[NSMutableArray alloc] init];
    [expectedEmoticons addObject:@"megusta"];
    [expectedEmoticons addObject:@"coffee"];
    
    XCTAssertEqualObjects(expectedEmoticons, emoticons, @"The array of emoticon did not match the expected emoticon");
    
}

- (void)testParseStringToLinks{
    NSString *message = @"Olympics are starting soon; http://www.nbcolympics.com";
    
    HipChatMessage *hipchat = [[HipChatMessage alloc] initWithHipChatMessage:message];
    [hipchat parseStringToLinks:message];
    
    NSMutableArray *links = [[NSMutableArray alloc] initWithCapacity:0];
    for (Link *obj in hipchat.links) {
        NSMutableArray *arrLinkAndTitle = [[NSMutableArray alloc] initWithCapacity:0];
        [arrLinkAndTitle addObject:obj.urlString];
        [arrLinkAndTitle addObject:obj.title];

        [links addObject:arrLinkAndTitle];
    }
    
    // Expected ouput
    NSMutableArray *expectedLinkAndTitle = [[NSMutableArray alloc] initWithCapacity:0];
    [expectedLinkAndTitle addObject:@"http://www.nbcolympics.com"];
    [expectedLinkAndTitle addObject:@"NBC Olympics | Home of the 2016 Olympic Games in Rio"];

    NSMutableArray *expectedLinks = [[NSMutableArray alloc] init];
    [expectedLinks addObject:expectedLinkAndTitle];
    
    XCTAssertEqualObjects(expectedLinks, links, @"The array of link did not match the expected link");
}

- (void)testGetUserNames{
    NSString *message = @"@bob @john (success) such a cool feature";
    
    HipChatMessage *hipchat = [[HipChatMessage alloc] initWithHipChatMessage:message];
    [hipchat parseStringToMentions:message];
    
    NSMutableArray *mentions = [[NSMutableArray alloc] initWithCapacity:0];
    for (Mention *obj in hipchat.mentions) {
        [mentions addObject:obj.userName];
    }
    
    // Expected ouput
    NSMutableArray *expectedMentions = [[NSMutableArray alloc] init];
    [expectedMentions addObject:@"bob"];
    [expectedMentions addObject:@"john"];
    
    XCTAssertEqualObjects(expectedMentions, mentions, @"The array of mention did not match the expected mention");
}

- (void)testGetEmoticons{
    NSString *message = @"Good morning! (megusta) (coffee)";
    
    HipChatMessage *hipchat = [[HipChatMessage alloc] initWithHipChatMessage:message];
    [hipchat parseStringToEmoticons:message];
    
    NSMutableArray *emoticons = [[NSMutableArray alloc] initWithCapacity:0];
    for (Emoticon *obj in hipchat.emoticons) {
        [emoticons addObject:obj.emoticon];
    }
    
    // Expected ouput
    NSMutableArray *expectedEmoticons = [[NSMutableArray alloc] init];
    [expectedEmoticons addObject:@"megusta"];
    [expectedEmoticons addObject:@"coffee"];
    
    XCTAssertEqualObjects(expectedEmoticons, emoticons, @"The array of emoticon did not match the expected emoticon");
}

- (void)testGetURLandTitles{
    NSString *message = @"the newspaper published in Melbourne, Australia; http://www.heraldsun.com.au";
    
    HipChatMessage *hipchat = [[HipChatMessage alloc] initWithHipChatMessage:message];
    [hipchat parseStringToLinks:message];
    
    NSMutableArray *links = [[NSMutableArray alloc] initWithCapacity:0];
    for (Link *obj in hipchat.links) {
        NSMutableArray *arrLinkAndTitle = [[NSMutableArray alloc] initWithCapacity:0];
        [arrLinkAndTitle addObject:obj.urlString];
        [arrLinkAndTitle addObject:obj.title];
        
        [links addObject:arrLinkAndTitle];
    }
    
    // Expected ouput
    NSMutableArray *expectedLinkAndTitle = [[NSMutableArray alloc] initWithCapacity:0];
    [expectedLinkAndTitle addObject:@"http://www.heraldsun.com.au"];
    [expectedLinkAndTitle addObject:@"Herald Sun |  Latest Melbourne & Victoria News | HeraldSun"];
    
    NSMutableArray *expectedLinks = [[NSMutableArray alloc] init];
    [expectedLinks addObject:expectedLinkAndTitle];
    
    XCTAssertEqualObjects(expectedLinks, links, @"The array of link and titlt did not match the expected link and title");
}
@end
