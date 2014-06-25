//
// Created by Cyrus on 6/24/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockLunchUpdater.h"


@implementation MockLunchUpdater {

    NSObject <LunchProtocol> *lunchForUpdate;
    NSObject <LocationProtocol> *locationForUpdate;
}
- (void)updateLunch:(NSObject <LunchProtocol> *)lunch withLocation:(NSObject <LocationProtocol> *)location {
    lunchForUpdate = lunch;
    locationForUpdate = location;
}

-(NSObject<LocationProtocol> *) getLocationForUpdate{
    return locationForUpdate;
}
-(NSObject<LunchProtocol> *)getLunchForUpdate{
    return lunchForUpdate;
}
@end