//
//  Card.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import "Card.h"


@implementation Card


- (BOOL)isEqual:(id)other {
  if (other == self)
    return YES;
  if (!other || ![other isKindOfClass: [self class]])
    return NO;
  if (! [self.contents isEqualToString: ((Card *) other).contents])
    return NO;
  return YES;
}


- (void)hideCard {
  self.hidden = YES;
}

//virtual
- (NSUInteger)numberOfCards {
  return 0;
}

- (NSUInteger)integerContents {
  return 0;
}

@end
