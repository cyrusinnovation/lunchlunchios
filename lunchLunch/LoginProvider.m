//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LoginProvider.h"
#import "NullPerson.h"


@implementation LoginProvider {

    NSMutableData *connectionData;

    NSObject <ConnectionFactoryProtocol> *connectionFactory;
    NSObject<PersonReceiverProtocol>* receiver;
    NSObject<PersonParserProtocol> * parser;
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
- (void)findPersonByEmail:(NSString *)email {
    NSString *loginURL = [NSString stringWithFormat:@"http://localhost:3000/login?email=%@", email];
    [connectionFactory buildAsynchronousGetRequestForURL:loginURL andDelegate:self];
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
    [receiver handlePersonFound:[NullPerson singleton]];

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

@end