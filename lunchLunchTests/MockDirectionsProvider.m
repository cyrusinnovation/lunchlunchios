//
// Created by Cyrus on 6/20/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockDirectionsProvider.h"


@implementation MockDirectionsProvider {

    NSObject <LocationProtocol> *locationForFindDirection;
    CLLocation *originForFindDirection;
}
- (void)findDirectionsTo:(NSObject <LocationProtocol> *)location fromOrigin:(CLLocation *)origin {
    locationForFindDirection = location;
    originForFindDirection = origin;
}

-(NSObject<LocationProtocol> *) getLocationForFindDirection{
    return locationForFindDirection;
}
-(CLLocation *) getOriginForFindDirection{
    return originForFindDirection;
}
@end