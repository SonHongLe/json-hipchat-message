//
//  HipChatMessage.m
//  JSONHipChat
//
//  Created by Sonny on 8/16/15.
//  Copyright (c) 2015 Son Hong Le. All rights reserved.
//

#import "HipChatMessage.h"
#import "Mention.h"
#import "Emoticon.h"
#import "Link.h"
#import "TFHpple.h"

#define TITLE_TAG @"//title"
#define MENTIONS_KEY @"mentions"
#define EMOTICONS_KEY @"emoticons"
#define LINKS_KEY @"links"
#define URL_KEY @"url"
#define TITLE_KEY @"title"

@interface HipChatMessage()

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

@implementation HipChatMessage

#pragma mark - Inittialize
/**
 *   @brief  Initializer
 *
 *   @input  a message
 *
 *   @return array of "mention", array of "emoticon", array of "link"
 *
 */
- (id)initWithHipChatMessage:(NSString *)message{
    self = [super init];
    if (self) {
        
        // Parse a message to get a list of mention
        [self parseStringToMentions:message];

        // Parse a message to get a list of emoticon
        [self parseStringToEmoticons:message];
        
        // Parse a message to get a list of link and webpage title
        [self parseStringToLinks:message];
    }
    
    return self;
}

#pragma mark - Parser Functions
/**
 *   @brief  Get array of "mention" in a message
 *
 *   @input  a message
 *
 *   @return array of "mention"
 *
 */
- (void)parseStringToMentions:(NSString *)message{
    NSMutableArray * newMentions = [[NSMutableArray alloc] initWithCapacity:0];
    
    // Remove whitespace and newline at beginning and trailing of a messge
    message = [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (message.length > 0) {
        int length = message.length;
        
        for (int i = 0; i < length; i++) {
            // A character is "@"?
            if ([Mention isASCII64:[message characterAtIndex:i]]) {

                // A character is in the end of a message?
                if (i < length - 1) {
                    
                    // Find mention string
                    for (int j = i + 1; j < length; j++) {
                        unichar character = [message characterAtIndex:j];
                        
                        // A character is in the end of a message?
                        if (j == length - 1) {
                            Mention *thisMention = [[Mention alloc] init];
                            
                            // a current character is a non word character?
                            if ([Mention isNonWordCharacter:character]) {
                                
                                // get user name string from message
                                NSRange range = NSMakeRange(i + 1, j - 1 - i);
                                thisMention.userName = [message substringWithRange:range];
                                
                                // Move index to a previous character of non word character
                                i = j - 1;
                            }else{

                                // get user name string from message
                                NSRange range = NSMakeRange(i + 1, j - i);
                                thisMention.userName = [message substringWithRange:range];
                                
                                // Move index to the end of message
                                i = j;
                            }
                            
                            // Add mention into array
                            [newMentions addObject:thisMention];
                            break;
                            
                        }else if([Mention isNonWordCharacter:character]){
                            Mention *thisMention = [[Mention alloc] init];
                            
                            // get user name string from message
                            NSRange range = NSMakeRange(i + 1, j - 1 - i);
                            thisMention.userName = [message substringWithRange:range];
                            
                            // Add mention into array
                            [newMentions addObject:thisMention];
                            
                            // Move index to a previous character of non word character
                            i = j - 1;
                            break;
                            
                        } // if
                    } // for
                }
            }
        } // for
    }
    
    self.mentions = newMentions;

    /*
    for (Mention *obj in self.mentions) {
        NSLog(@"mentions: %@", obj.userName);
    }
     */
}

/**
 *   @brief  Get array of "emoticon" in a message
 *
 *   @input  a message
 *
 *   @return array of "emoticon"
 *
 */
- (void)parseStringToEmoticons:(NSString *)message{
    NSMutableArray * newEmoticons = [[NSMutableArray alloc] initWithCapacity:0];
    
    // Remove whitespace and newline at beginning and trailing of a messge
    message = [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (message.length > 0) {
        int length = message.length;
        
        for (int i = 0; i < length; i++) {
            // A character is "("?
            if ([Emoticon isLeftParenthesis:[message characterAtIndex:i]]) {
                // A character is in the end of a message?
                if (i < length - 1) {
                    // Find emoticon string
                    for (int j = i + 1; j < length; j++) {
                        unichar character = [message characterAtIndex:j];
                        
                        // A character is ")"?
                        if ([Emoticon isRightParenthesis:character]) {
                            
                            // Extract emoticon string from massage
                            NSRange range = NSMakeRange(i + 1, j - 1 - i);
                            NSString *emoticon = [message substringWithRange:range];
                            
                            // Validate the length of emotion string
                            if ([Emoticon isValidLength:emoticon]) {
                                Emoticon *emoticonObj = [[Emoticon alloc] init];
                                emoticonObj.emoticon = emoticon;
                                
                                // Add emoticon into array
                                [newEmoticons addObject:emoticonObj];
                            }
                            
                            // Move index to ")" character
                            i = j;
                            break;
                        }
                    } // for
                }
            }
        } // for
    }
    
    self.emoticons = newEmoticons;
    
    /*
    for (Emoticon *obj in self.emoticons) {
        NSLog(@"emoticon: %@", obj.emoticon);
    }
     */
}

/**
 *   @brief  Get array of url and webpage title
 *
 *   @input  a message
 *
 *   @return array of "emoticon"
 *
 */
- (void)parseStringToLinks:(NSString *)message{
    NSMutableArray *newLinks = [[NSMutableArray alloc] initWithCapacity:0];

    // Initialize detector of type link
    NSDataDetector *detect = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    
    // Get strings that contain validurl URL link
    NSArray *matches = [detect matchesInString:message options:0 range:NSMakeRange(0, [message length])];
    
    // Get webpage title for each url link
    for (NSTextCheckingResult *match in matches) {
        NSURL *linkURL = [match URL];
            
        NSData *linkHtmlData = [NSData dataWithContentsOfURL:linkURL];
        
        TFHpple *linkParser = [TFHpple hppleWithHTMLData:linkHtmlData];
        
        // Set tag is <title></title>
        NSString *linkXpathQueryString = TITLE_TAG;
        
        // Parser toget node "title"
        NSArray *linkNodes = [linkParser searchWithXPathQuery:linkXpathQueryString];
        
        for (TFHppleElement *element in linkNodes) {
            
            // Get url and title
            Link *linkObj = [[Link alloc] init];
            linkObj.urlString = [linkURL absoluteString];
            linkObj.title = [[element firstChild] content];
            
            // Add Links object into array
            [newLinks addObject:linkObj];
        }
    }
    
    self.links = newLinks;
    
    /*
    for (Link *obj in self.links) {
        NSLog(@"link: %@, title: %@", obj.urlString, obj.title);
    }
     */
}

/**
 *   @brief  Get json string from HipChatMessage object
 *
 *   @input  HipChatMessage object
 *
 *   @return json string
 *
 */
- (NSString *)getJSON{
    NSString *result= nil;
    
    // Get array of user name from HipChatMessage object
    NSMutableArray *arrMentions = [self getUserNames:self.mentions];
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];

    // Add array of user name into dictionary with key "mentions"
    if (arrMentions.count > 0) {
        [mutableDict setObject:arrMentions forKey:MENTIONS_KEY];
    }

    // Get array of emoticon from HipChatMessage object
    NSMutableArray *arrEmoticons = [self getEmoticons:self.emoticons];
    
    // Add array of emoticon into dictionary with key "emoticons"
    if (arrEmoticons.count > 0) {
        [mutableDict setObject:arrEmoticons forKey:EMOTICONS_KEY];
    }

    // Get array of dictionary [url: value, title: value] from HipChatMessage object
    NSMutableArray *arrLinks = [self getURLandTitles:self.links];
    
    // Add array of dictionary [url: value, title: value] into dictionary with key "links"
    if (arrLinks.count > 0) {
        [mutableDict setObject:arrLinks forKey:LINKS_KEY];
    }
    
    // retun nil if do not have anay mentions, emoticon, links
    if (arrMentions.count == 0 && arrEmoticons.count == 0 && arrLinks.count == 0) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *json;
    
    NSDictionary *dict = [mutableDict copy];
    // Dictionary convertable to JSON?
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        // Serialize the dictionary
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (json != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            
            // Remove extra backslashes of json string
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
            result = jsonString;
        }
    }
    
    return result;
}

/**
 *   @brief  Get user name
 *
 *   @input  array of mention
 *
 *   @return array of "user name"
 *
 */
- (NSMutableArray *)getUserNames:(NSMutableArray *)mentions{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    for (Mention *obj in mentions) {
        [result addObject:obj.userName];
    }

    return result;
}

/**
 *   @brief  Get emoticons
 *
 *   @input  array of mention
 *
 *   @return array of "emoticon"
 *
 */
- (NSMutableArray *)getEmoticons:(NSMutableArray *)emoticons{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    for (Emoticon *obj in emoticons) {
        [result addObject:obj.emoticon];
    }

    return result;
}

/**
 *   @brief  Get url  and title of that url's webpage
 *
 *   @input  array of mention
 *
 *   @return array of "emoticon"
 *
 */
- (NSMutableArray *)getURLandTitles:(NSMutableArray *)links{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    for (Link *obj in links) {
        NSMutableDictionary *thisLink = [[NSMutableDictionary alloc] init];
        
        // Add a string with key "url" into dictionary
        [thisLink setObject:obj.urlString forKey:URL_KEY];

        // Add a string with key "title" into dictionary
        [thisLink setObject:obj.title forKey:TITLE_KEY];
        
        // Add dictionary in to array
        [result addObject:thisLink];
    }
    
    return result;
}

@end



