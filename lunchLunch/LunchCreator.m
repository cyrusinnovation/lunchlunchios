//
// Created by Cyrus on 4/22/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchCreator.h"
#import "LunchCreationHandler.h"
#import "Constants.h"


@implementation LunchCreator {
    NSObject <ConnectionFactoryProtocol> *connectionFactory;

    NSObject <LunchParserProtocol> *lunchParser;
    NSObject <LunchCreationHandler> *lunchCreationHandler;

}
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory
                    lunchParser:(NSObject <LunchParserProtocol> *)lunchParserForInit
        andLunchCreationHandler:(NSObject <LunchCreationHandler> *)createHandler {
    self = [super init];
    if (self) {
        connectionFactory = factory;
        lunchCreationHandler = createHandler;
        lunchParser = lunchParserForInit;
    }
    return self;
}

- (void)createLunch:(NSObject <LunchProtocol> *)lunch {
    NSData *lunchData = [lunchParser buildLunchJSONData:lunch];
    NSString *url = [NSString stringWithFormat:@"%@/createLunch", SERVICE_URL];
    [connectionFactory postData:lunchData toURL:url withDelegate:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [lunchCreationHandler handleLunchCreated];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [lunchCreationHandler handleLunchCreationFailed];
}


- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return connectionFactory;
}

- (NSObject <LunchParserProtocol> *)getLunchParser {
    return lunchParser;
}


- (NSObject <LunchCreationHandler> *)getLunchCreationHandler {
    return lunchCreationHandler   ;
}


@end