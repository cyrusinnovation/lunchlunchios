//
// Created by Cyrus on 4/18/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchProvider.h"
#import "ConnectionFactoryProtocol.h"
#import "LunchParserProtocol.h"
#import "PersonParserProtocol.h"
#import "LunchReceiverProtocol.h"


@implementation LunchProvider {

    NSObject <ConnectionFactoryProtocol> *connectionFactory;
    NSObject <PersonParserProtocol>* personParser;
    NSObject <LunchParserProtocol> *lunchParser;
    NSObject <LunchReceiverProtocol> *lunchReceiver;
    NSMutableData *connectionData;
}
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory
                    lunchParser:(NSObject <LunchParserProtocol> *)lunchParserForInit
                   personParser:(NSObject <PersonParserProtocol> *)personParserForInit andLunchReceiver:(NSObject <LunchReceiverProtocol> *)receiver {
    self = [super init];
    if (self) {
        connectionFactory = factory;
        personParser = personParserForInit;
        lunchReceiver = receiver;
        lunchParser = lunchParserForInit;
    }
    return self;
}


- (void)findLunchesFor:(NSObject <PersonProtocol> *)person {
    NSString *personString = [[personParser buildPersonJSONString:person] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://localhost:3000/getLunches?person=%@", personString];
    [connectionFactory buildAsynchronousGetRequestForURL:url andDelegate:self];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [lunchReceiver handleLunchesFound:[NSArray arrayWithObjects:nil]];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    connectionData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {    
    [connectionData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSArray *lunches = [lunchParser parseLunches:connectionData];
    [lunchReceiver handleLunchesFound:lunches];
}


- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return connectionFactory;
}

- (NSObject <LunchParserProtocol> *)getLunchParser {
    return lunchParser;
}

- (NSObject <PersonParserProtocol> *)getPersonParser {
    return personParser;
}

- (NSObject <LunchReceiverProtocol> *)getLunchReceiver {
    return lunchReceiver;
}


@end