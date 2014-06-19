//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "DirectionsProvider.h"
#import "ConnectionFactoryProtocol.h"
#import "DirectionHandlerProtocol.h"
#import "PersonProtocol.h"


@implementation DirectionsProvider {
    NSObject <ConnectionFactoryProtocol> *connectionFactory;
    NSObject <DirectionHandlerProtocol> * directionHandler;
    NSMutableData *connectionData;
}


@synthesize connectionData;

- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory andDirectionHandler:(NSObject <DirectionHandlerProtocol> *)handler {
    self = [super init];
    if (self) {
        connectionFactory = factory;
        directionHandler = handler;
    }
    return self;
}

- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return connectionFactory;
}

- (NSObject <DirectionHandlerProtocol> *)getDirectionHandler {
    return directionHandler;
}

- (void)findDirectionsTo:(NSObject <LocationProtocol> *)location fromOrigin:(CLLocation *)origin {
    double latitude = origin.coordinate.latitude;
    double longitude= origin.coordinate.longitude;
    NSMutableString *mapAPIURL = [[NSMutableString alloc] init];
    NSDate *now = [NSDate date];
    [mapAPIURL appendString:@"http://maps.googleapis.com/maps/api/directions/json?sensor=true"];
    [mapAPIURL appendFormat:@"&origin=%f,%f", latitude, longitude];
    [mapAPIURL appendString:@"&destination="];
    [mapAPIURL appendString:[location getAddress]];
    [mapAPIURL appendString:@","];
    [mapAPIURL appendString:[location getZipCode]];
    [mapAPIURL appendFormat:@"&departure_time=%.0f", [now timeIntervalSince1970]];
    [mapAPIURL appendString:@"&mode=transit"];
    NSString* escapedString = [mapAPIURL
            stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];

    [connectionFactory buildAsynchronousGetRequestForURL:escapedString andDelegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    connectionData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [connectionData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [directionHandler handleDirectionFailed];
}


@end