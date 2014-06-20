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
    double latitude = origin.coordinate.latitude;
    double longitude= origin.coordinate.longitude;
    NSMutableString *mapAPIURL = [[NSMutableString alloc] init];
    [mapAPIURL appendString:@"http://maps.google.com/maps?"];
    [mapAPIURL appendFormat:@"&saddr=%f,%f", latitude, longitude];
    [mapAPIURL appendString:@"&daddr="];
    [mapAPIURL appendString:[location getAddress]];
    [mapAPIURL appendString:@","];
    [mapAPIURL appendString:[location getZipCode]];
    [mapAPIURL appendString:@"&dirflg=r"];
    NSString*escapedUrlString = [mapAPIURL
            stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    [connectionFactory openURL:escapedUrlString];
}




@end