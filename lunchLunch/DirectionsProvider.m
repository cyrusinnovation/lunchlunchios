//
// Created by Cyrus on 5/23/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "DirectionsProvider.h"
#import "ConnectionFactoryProtocol.h"
#import "PersonProtocol.h"


@implementation DirectionsProvider {
    NSObject <ConnectionFactoryProtocol> *connectionFactory;
}


@synthesize connectionData;


- (id)initWithConnectionFactory:(NSObject <ConnectionFactoryProtocol> *)factory {
    self = [super init];
    if(self){
        connectionFactory = factory;
    }

    return self;
}

- (NSObject <ConnectionFactoryProtocol> *)getConnectionFactory {
    return connectionFactory;
}


- (void)findDirectionsTo:(NSObject <LocationProtocol> *)location fromOrigin:(CLLocation *)origin {

    if([[UIApplication sharedApplication] canOpenURL:
            [NSURL URLWithString:@"comgooglemaps-x-callback://"]]){
        [self openGoogleMapsApp:location origin:origin];
    }   else {
        [self openGoogleMapsInSafari:location origin:origin];
    }
}

- (void)openGoogleMapsInSafari:(NSObject <LocationProtocol> *)location origin:(CLLocation *)origin {
    NSString *escapedUrlString = [self buildMapURL:location origin:origin withBaseURL:@"http://maps.google.com/maps?" andTransitMode:@"&dirflg=r"];
    [connectionFactory openURL:escapedUrlString];
}
- (void)openGoogleMapsApp:(NSObject <LocationProtocol> *)location origin:(CLLocation *)origin {
    NSString *escapedUrlString = [self buildMapURL:location origin:origin withBaseURL:@"comgooglemaps-x-callback://?" andTransitMode:@"&directionsmode=transit"];
    [connectionFactory openURL:escapedUrlString];
}


- (NSString *)buildMapURL:(NSObject <LocationProtocol> *)location origin:(CLLocation *)origin withBaseURL:(NSString*) baseUrl andTransitMode:(NSString *) transitString{
    double latitude = origin.coordinate.latitude;
    double longitude= origin.coordinate.longitude;
    NSMutableString *mapAPIURL = [[NSMutableString alloc] init];
    [mapAPIURL appendString:baseUrl];
    [mapAPIURL appendFormat:@"&saddr=%f,%f", latitude, longitude];
    [mapAPIURL appendString:@"&daddr="];
    [mapAPIURL appendString:[location getAddress]];
    [mapAPIURL appendString:@","];
    [mapAPIURL appendString:[location getZipCode]];
    [mapAPIURL appendString:transitString];
    NSString *escapedUrlString = [mapAPIURL
                stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return escapedUrlString;
}


@end