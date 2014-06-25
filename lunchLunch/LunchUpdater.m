//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "LunchUpdater.h"
#import "ConnectionFactoryProtocol.h"
#import "LocationParserProtocol.h"
#import "LunchUpdateHandler.h"


@implementation LunchUpdater {

    NSObject <ConnectionFactoryProtocol> *connectionFactory;

    NSObject <LunchUpdateHandler> *lunchUpdateHandler;
}
- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory andUpdateHandler:(NSObject <LunchUpdateHandler> *)handler {
    self = [super init];
    if (self) {
        connectionFactory = factory;

        lunchUpdateHandler = handler;
    }
    return self;
}



- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return connectionFactory;
}

- (NSObject <LunchUpdateHandler> *)getUpdateHandler {
    return lunchUpdateHandler;
}

- (void)updateLunch:(NSObject <LunchProtocol> *)lunch withLocation:(NSObject <LocationProtocol> *)location {

    NSDictionary *locationDictionary = [self buildLocationDictionary:location];
    NSDictionary *lunchDictionary = [NSDictionary dictionaryWithObject:[lunch getId] forKey:@"_id"];
    NSDictionary *dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:lunchDictionary, @"lunch",
                    locationDictionary, @"location",nil];
    NSData *putData = [NSJSONSerialization dataWithJSONObject:dataDictionary options:NSJSONWritingPrettyPrinted error:nil];
    [connectionFactory putData:putData toURL:@"http://localhost:3000/setlunchlocation" withDelegate:self];
}

- (NSDictionary *)buildLocationDictionary:(NSObject<LocationProtocol> *)location {
    return [NSDictionary dictionaryWithObjectsAndKeys:[location getName], @"name", [location getAddress], @"address", [location getZipCode], @"zipCode", [location getId],@"_id", nil];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [lunchUpdateHandler handleLunchUpdate];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [lunchUpdateHandler handleLunchUpdateFailed];
}

@end