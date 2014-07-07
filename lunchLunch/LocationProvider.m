//
// Created by Cyrus on 6/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationProvider.h"
#import "Constants.h"


@implementation LocationProvider {

    NSObject <LocationReceiverProtocol> *locationReceiver;
    NSObject <LocationParserProtocol> *locationParser;
    NSObject <ConnectionFactoryProtocol> *connectionFactory;
    NSMutableData *connectionData;
}

- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory parser:(NSObject <LocationParserProtocol> *)parser andLocationReceiver:(NSObject <LocationReceiverProtocol> *)receiver {
    self = [super init];
    if (self) {
        connectionFactory = factory;
        locationParser = parser;
        locationReceiver= receiver;
    }

    return self;
}
- (void)getAllLocations {
    NSString *url = [NSString stringWithFormat:@"%@/locations", SERVICE_URL];
    [connectionFactory buildAsynchronousGetRequestForURL:url andDelegate:self];
}

- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return connectionFactory;
}

- (NSObject <LocationParserProtocol> *)getLocationParser {
    return locationParser;
}

- (NSObject <LocationReceiverProtocol> *)getLocationReceiver {
    return locationReceiver;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    connectionData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [connectionData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSArray *locations = [locationParser parseLocationList:connectionData];
    [locationReceiver handleLocationsFound:locations];
}

@end