// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XCTest/XCTest.h>

#import "AnnouncementListDataDisplayManager.h"
#import "AnnouncementViewModel.h"
#import "AnnouncementListTableViewCell.h"

#import <OCMock/OCMock.h>
#import "AnnouncementListTableViewController.h"

typedef NS_ENUM(NSUInteger, TableViewSectionIndex){
    EventsSection = 0
};

@interface AnnouncementListDataDisplayManagerTests : XCTestCase

@property (strong, nonatomic) AnnouncementListDataDisplayManager *dataDisplayManager;
@property (strong, nonatomic) NSArray *events;

@end

@implementation AnnouncementListDataDisplayManagerTests

- (void)setUp {
    [super setUp];
    
    self.dataDisplayManager = [AnnouncementListDataDisplayManager new];
    self.events = [self generateViewModels];
}

- (void)tearDown {
    self.dataDisplayManager = nil;
    self.events = nil;
    
    [super tearDown];
}

- (void)testThatDataDisplayManagerReturnsTableViewDataSource {
    // given
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:nil];
    
    // then
    XCTAssertNotNil(dataSource);
}

- (void)testSuccessUpdateTableViewModelWithEvents {
    // given
    id mockViewController = OCMClassMock([AnnouncementListTableViewController class]);
    self.dataDisplayManager.delegate = mockViewController;
    
    // when
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    
    // then
    OCMVerify([mockViewController didUpdateTableViewModel]);
    [mockViewController stopMocking];
}

- (void)testThatDataDisplayManagerReturnsCorrectNumberOfSections {
    // given
    NSUInteger const kExpectedNumberOfSections = 1;
    NSUInteger actualNumberOfSections = 0;
    UITableView *tableView = [UITableView new];

    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:tableView];
    
    // when
     actualNumberOfSections = [dataSource numberOfSectionsInTableView:tableView];
    
    // then
    XCTAssertEqual(actualNumberOfSections, kExpectedNumberOfSections);
}

- (void)testThatDataDisplayManagerReturnsCorrectNumberOfRows {
    // given
    NSUInteger const kExpectedNumberOfRows = self.events.count;
    NSUInteger actualNumberOfRows = 0;
    UITableView *tableView = [UITableView new];
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:tableView];
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];

    // when
    actualNumberOfRows = [dataSource tableView:tableView numberOfRowsInSection:EventsSection];

    // then
    XCTAssertEqual(kExpectedNumberOfRows, actualNumberOfRows);
}

- (void)testThatDataDisplayManagerReturnsCorrectClassForTableViewCell {
    // given
    NSUInteger expectedNumberOfCellForCorrespondingClass = self.events.count;
    NSUInteger actualNumberOfCellForCorrespondingClass = 0;
    UITableView *tableView = [UITableView new];

    // when
    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:tableView];
    [self.dataDisplayManager updateTableViewModelWithEvents:self.events];

    NSUInteger numberOfRows = [dataSource tableView:tableView numberOfRowsInSection:EventsSection];
    
    for (int i = 0; i < numberOfRows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:EventsSection];
        UITableViewCell *cell = [dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        
        if ([cell isKindOfClass:[AnnouncementListTableViewCell class]]) {
            actualNumberOfCellForCorrespondingClass++;
        }
    }
    
    // then
    XCTAssertEqual(expectedNumberOfCellForCorrespondingClass, actualNumberOfCellForCorrespondingClass);
}

#pragma mark - Вспомогательные методы

- (NSArray *)generateViewModels {
    NSMutableArray *viewModels = [NSMutableArray new];
    for (NSInteger index = 0; index < 3; index++) {
        [viewModels addObject:[AnnouncementViewModel new]];
    }
    
    return viewModels;
}

@end