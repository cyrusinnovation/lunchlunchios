//
// Created by Cyrus on 4/2/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "PersonProvider.h"
#import "Person.h"
#import "PersonRetrieverProtocol.h"
#import "NullPerson.h"


@implementation PersonProvider {

}

- (id)initWithRetriever:(NSObject <PersonRetrieverProtocol> *)retriever {
    self = [super init];
    if(self){
        personRetriever = retriever;
    }
    return self;
}

- (NSObject <PersonProtocol> *)findPersonByEmail:(NSString *)emailToFind {
    for (NSObject<PersonProtocol>* person in [personRetriever getAllPeople]){
        if([[person getEmailAddress] isEqualToString:emailToFind]){
            return person;
        }
    }
    return [NullPerson singleton];
}


@end