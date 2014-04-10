//
// Created by Cyrus on 4/4/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <objc/runtime.h>
#import "PersonProviderTestHelper.h"
#import "PersonProvider.h"
#import "SwizzleHelper.h"
#import "PersonProtocol.h"


NSObject <PersonProtocol> *personToReturn;

NSString *emailUsedToFindPerson;

@implementation PersonProviderTestHelper {

}
+ (void)swizzleGetPerson {
    SEL mockGetPersonSelector = @selector(mockFindPersonByEmail:);
    SEL originalSelector = @selector(findPersonByEmail:);

    Class originalClass = [PersonProvider class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod:mockMethodClass withSelector:mockGetPersonSelector];

    [SwizzleHelper swizzleMethodFunctionality:originalMethod withMockMethod:mockMethod];
}

+ (void)deswizzleGetPersonAndClearFields {
    SEL mockGetPersonSelector = @selector(mockFindPersonByEmail:);
    SEL originalSelector = @selector(findPersonByEmail:);

    Class originalClass = [PersonProvider class];
    Class mockMethodClass = [self class];

    Method originalMethod = [SwizzleHelper findInstanceMethod:originalClass withSelector:originalSelector];
    Method mockMethod = [SwizzleHelper findInstanceMethod: mockMethodClass withSelector:mockGetPersonSelector];

    [SwizzleHelper deswizzleMethodFunctionality:originalMethod awayFromMockMethod:mockMethod];
    personToReturn = nil;
    emailUsedToFindPerson = nil;
}
+ (void) setPersonToReturn:(NSObject <PersonProtocol>*) person{
    personToReturn= person;
}
+(NSString *) getEmailUsedToFindPerson{
    return emailUsedToFindPerson;
}
- (NSObject <PersonProtocol> *)mockFindPersonByEmail:(NSString *) email {
    emailUsedToFindPerson = email;
    return personToReturn;
}

@end