// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.

#import "CardViewInGrid.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardViewInGrid


- (NSString *)description
{
  return [NSString stringWithFormat:@" Card: %@, Location in Grid: %lu, View: %@",
          self.cardForView.contents, self.gridLocation, self.view];
}

@end

NS_ASSUME_NONNULL_END
