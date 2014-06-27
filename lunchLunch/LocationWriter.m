//
// Created by Cyrus on 6/26/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LocationWriter.h"
#import "NullLocation.h"


@implementation LocationWriter {

    NSObject <LocationParserProtocol> *locationParser;
    NSObject <LocationCreationHandler> *locationCreationHandler;
    NSObject <ConnectionFactoryProtocol> *connectionFactory;
    NSMutableData *connectionData;
}


- (NSObject <LocationParserProtocol> *)getLocationParser {
    return locationParser;
}

- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return connectionFactory;
}

- (NSObject <LocationCreationHandler> *)getLocationCreationHandler {
    return locationCreationHandler;
}

- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory parser:(NSObject <LocationParserProtocol> *)parser andCreationHandler:(NSObject <LocationCreationHandler> *)handler {
    self = [super init];
    if(self){
        connectionFactory = factory;
        locationParser = parser;
        locationCreationHandler = handler;
    }
    return self;
}

- (void)createLocationWithName:(NSString *)name address:(NSString *)address andZipCode:(NSString *)zipCode {
    NSData *locationData = [locationParser formatJSONWithName:name withAddress:address andZipCode:zipCode];
    [connectionFactory postData:locationData toURL:@"http://localhost:3000/createLocation" withDelegate:self];

}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    connectionData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [connectionData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSObject <LocationProtocol> *location = [locationParser parseLocationUsingJsonData:connectionData];
    if([location isEqual:[NullLocation singleton]]){
        [locationCreationHandler locationSaveError];
    }   else {
        [locationCreationHandler locationSaved:location];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [locationCreationHandler locationSaveError];
}

@end