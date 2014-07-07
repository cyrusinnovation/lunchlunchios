#import <XCTest/XCTest.h>
#import "Constants.h"

@interface ConstantsTest : XCTestCase
@end

@implementation ConstantsTest {

}
- (void)testConstant {
    XCTAssertEqualObjects(@"http://localhost:3000", SERVICE_URL);
}
@end