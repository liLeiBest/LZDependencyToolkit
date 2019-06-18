//
//  LZDependencyToolkitTests.m
//  LZDependencyToolkitTests
//
//  Created by lilei_hapy@163.com on 11/14/2017.
//  Copyright (c) 2017 lilei_hapy@163.com. All rights reserved.
//

@import XCTest;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTimestampToDate {
	
	NSString *today = [NSDate currentTimeStamp];
	NSDate *date = [NSDate dateFormatToDate:today formats:@[@"yyyy-MM-dd"]];
	NSString *dateDesc = [date dateFormatToYMD];
	XCTAssertNotNil(dateDesc, @"出错了");
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end

