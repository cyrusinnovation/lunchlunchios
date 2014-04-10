//
// Created by Cyrus on 4/9/14.
// Copyright (c) 2014 Cyrus Innovation. All rights reserved.
//

#import "MockUITableView.h"


@implementation MockUITableView {
    id cellToReturn;
    NSString *identifierForDequeue;
    NSIndexPath *indexPathForDequeue;
}
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    identifierForDequeue = identifier;
    indexPathForDequeue = indexPath;

    return cellToReturn;
}
-(void) setCellToReturn:(UITableViewCell *) tableViewCell{
    cellToReturn = tableViewCell;
}
-(NSString *) getIdentifierForDequeue{
    return identifierForDequeue;
}
-(NSIndexPath *) getIndexPathForDequeue{
    return indexPathForDequeue;
}

@end