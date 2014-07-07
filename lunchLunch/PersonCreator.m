//
// Created by Cyrus on 7/3/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonCreator.h"
#import "NullPerson.h"


@interface PersonCreator ()
@property(nonatomic, strong) NSObject <PersonReceiverProtocol> *receiver;
@property(nonatomic, strong) NSObject <PersonParserProtocol> *parser;
@property(nonatomic, strong) NSObject <ConnectionFactoryProtocol> *factory;
@end

@implementation PersonCreator {


    NSMutableData *connectionData;
}

- (void)createPersonWithFirstName:(NSString *)firstName lastName:(NSString *)lastName andEmail:(NSString *)email {
    NSData *data = [self.parser buildPersonJSONWithFirstName:firstName lastName:lastName emailAddress:email];
    [self.factory postData:data toURL:@"http://localhost:3000/createPerson" withDelegate:self];
}

- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory
                   personParser:(NSObject <PersonParserProtocol> *)parser
              andPersonReceiver:(NSObject <PersonReceiverProtocol> *)receiver {
    self = [super init];
    if (self) {
        self.factory = factory;
        self.parser = parser;
        self.receiver = receiver;
    }
    return self;

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.receiver handlePersonFoundError];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    connectionData = [[NSMutableData alloc] init];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [connectionData appendData:data];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSObject <PersonProtocol> *person = [self.parser parsePersonUsingJsonData:connectionData];
    if([person isEqual:[NullPerson singleton]]){
        [self.receiver handlePersonFoundError];
    }
    else {
        [self.receiver handlePersonFound:person];
    }
}


- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return self.factory;
}

- (NSObject <PersonParserProtocol> *)getPersonParser {
    return self.parser;
}

- (NSObject <PersonReceiverProtocol> *)getPersonReceiver {
    return self.receiver;
}


@end