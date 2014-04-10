//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "CommandDispatcherTestHelper.h"
#import "SwizzleHelper.h"
#import "CommandDispatcher.h"
#import "Command.h"


NSObject <Command> *lastCommandExecuted;

@implementation CommandDispatcherTestHelper {

}

-(void) stubExecute: (NSObject <Command> *)command{
    lastCommandExecuted = command;


}
+ (NSObject<Command>*) getLastCommandExecuted{
    return lastCommandExecuted;
}

+ (void)swizzleExecute {
    SEL mockExecuteSelector = @selector(stubExecute:);
    SEL originalSelector = @selector(executeCommand:);

    Class originalClass = [CommandDispatcher class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockExecuteSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}
+ (void)deswizzleExecuteAndClearLastCommandExecuted {
    SEL mockExecuteSelector = @selector(stubExecute:);
    SEL originalSelector = @selector(executeCommand:);

    Class originalClass = [CommandDispatcher class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockExecuteSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    lastCommandExecuted = nil;
}

@end