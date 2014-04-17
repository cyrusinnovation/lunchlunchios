//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LoginProvider.h"
#import "Person.h"
#import "NullPerson.h"
#import "ConnectionFactoryProtocol.h"
#import "PersonReceiverProtocol.h"
#import "PersonParserProtocol.h"


@implementation LoginProvider {

    NSMutableData *connectionData;
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
-(NSObject <ConnectionFactoryProtocol>*) getConnectionFactory{
    return connectionFactory;
}

-(NSObject <PersonParserProtocol>*) getPersonParser{
    return parser;
}
-(NSObject <PersonReceiverProtocol>*) getPersonReceiver{
    return receiver;
}
- (void)findPersonByEmail:(NSString *)email {
    NSString *loginURL = [NSString stringWithFormat:@"http://localhost:3000/login?email=%@", email];
    [connectionFactory buildAsynchronousRequestForURL:loginURL andDelegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    connectionData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [connectionData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSObject <PersonProtocol> *parsedPerson = [parser parsePerson:connectionData];
    [receiver handlePersonFound:parsedPerson];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [receiver handlePersonFound:[NullPerson singleton]];

}

@end