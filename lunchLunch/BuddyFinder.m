//
// Created by Cyrus on 4/21/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "BuddyFinder.h"
#import "NullPerson.h"
#import "Constants.h"


@implementation BuddyFinder {
    NSObject <ConnectionFactoryProtocol> *connectionFactory;
    NSObject <PersonReceiverProtocol> *receiver;
    NSObject <PersonParserProtocol> *parser;
    NSMutableData *connectionData;
}
- (void)findBuddyFor:(NSObject <PersonProtocol> *)person {
    NSData *personData = [parser buildPersonJSONData:person];
    NSString *url = [NSString stringWithFormat:@"%@/findBuddy", SERVICE_URL];

    [connectionFactory postData:personData toURL:url withDelegate:self];
}

- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory personParser:(NSObject <PersonParserProtocol> *)personParser andPersonReceiver:(NSObject <PersonReceiverProtocol> *)personReceiver {
    self = [super init];
    if (self) {
        connectionFactory = factory;
        receiver = personReceiver;
        parser = personParser;
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    connectionData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [connectionData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSObject <PersonProtocol> *parsedPerson = [parser parsePersonUsingJsonData:connectionData];
    [receiver handlePersonFound:parsedPerson];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [receiver handlePersonFoundError];

}

- (NSObject <PersonReceiverProtocol> *)getPersonReceiver {
    return receiver;
}

- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return connectionFactory;
}

- (NSObject <PersonParserProtocol> *)getPersonParser {
    return parser;
}


@end