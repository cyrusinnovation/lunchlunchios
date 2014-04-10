//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MockUITableView : UITableView
- (void)setCellToReturn:(UITableViewCell *)tableViewCell;

- (NSString *)getIdentifierForDequeue;

- (NSIndexPath *)getIndexPathForDequeue;
@end