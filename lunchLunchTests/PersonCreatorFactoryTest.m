#import <XCTest/XCTest.h>
#import "PersonCreatorFactory.h"
#import "PersonCreatorProtocol.h"
#import "PersonCreator.h"
#import "ConnectionFactory.h"
#import "PersonParser.h"
#import "MockPersonReceiver.h"

@interface PersonCreatorFactoryTest : XCTestCase
@end

@implementation PersonCreatorFactoryTest {

}
-(void)testWillCreatePersonCreator{
    MockPersonReceiver *receiver = [[MockPersonReceiver alloc] init];
    NSObject <PersonCreatorProtocol> *provider = [PersonCreatorFactory buildPersonCreator:receiver];
    XCTAssertTrue([provider isKindOfClass:[PersonCreator class]]);
    PersonCreator *actualCreator = (PersonCreator *) provider;
    XCTAssertEqualObjects([ConnectionFactory singleton], [actualCreator getConnectionFactory]);
    XCTAssertEqualObjects([PersonParser singleton], [actualCreator getPersonParser]);
    XCTAssertEqualObjects(receiver, [actualCreator getPersonReceiver]);
}
@end