//
//  TargetKeyboard.m
//  Enjoy
//
//  Created by Sam McCall on 5/05/09.
//

#import "TargetKeyboard.h"

#import "NJKeyInputField.h"

@implementation TargetKeyboard

+ (NSString *)serializationCode {
    return @"key";
}

- (NSDictionary *)serialize {
    return @{ @"type": @"key", @"key": @(_vk) };
}

+ (Target *)targetDeserialize:(NSDictionary *)serialization
                  withMappings:(NSArray *)mappings {
    TargetKeyboard *target = [[TargetKeyboard alloc] init];
    target.vk = [serialization[@"key"] intValue];
    return target;
}

- (void)trigger {
    CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, _vk, YES);
    CGEventPost(kCGHIDEventTap, keyDown);
    CFRelease(keyDown);
}

- (void)untrigger {
    CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, _vk, NO);
    CGEventPost(kCGHIDEventTap, keyUp);
    CFRelease(keyUp);
}

@end
