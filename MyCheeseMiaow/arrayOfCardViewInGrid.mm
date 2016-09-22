// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.


#import "arrayOfCardViewInGrid.h"

NS_ASSUME_NONNULL_BEGIN

@implementation arrayOfCardViewInGrid

- (NSMutableArray<CardViewInGrid *> *)arrayOfCardViewInGrid {
  if (!_arrayOfCardViewInGrid) {
    _arrayOfCardViewInGrid = [[NSMutableArray alloc] init];
  }
  return _arrayOfCardViewInGrid;
}

- (BOOL)doesThisArray: (NSArray *)array containTheCard: (Card *)card {
  for (id item in array) {
    if ([item isKindOfClass:[CardViewInGrid class]]) {
      if  ([((CardViewInGrid *)item).cardForView isEqual: card]) {
        return YES;
      }
    }
  }
  return NO;
}


- (Card *)cardForView: (UIView *)view {
  for (id item in self.arrayOfCardViewInGrid) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      if ([view isEqual: ((CardViewInGrid *)item).view])
        return ((CardViewInGrid *)item).cardForView;
    }
  }
  return 0;
}


- (UIView *)viewForCard: (Card *)card {
  for (id item in self.arrayOfCardViewInGrid) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      if ([card isEqual: ((CardViewInGrid *)item).cardForView])
        return ((CardViewInGrid *)item).view;
    }
  }
  return nil;
}

- (NSUInteger)locationForCard: (Card *)card {
  for (id item in self.arrayOfCardViewInGrid) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      if ([card isEqual: ((CardViewInGrid *)item).cardForView])
        return ((CardViewInGrid *)item).gridLocation;
    }
  }
  return 0;
}


- (void)removeEntry: (Card *)card {
  for (CardViewInGrid* item in self.arrayOfCardViewInGrid) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      if ([card isEqual: ((CardViewInGrid *)item).cardForView]) {
        [self.arrayOfCardViewInGrid
         removeObjectAtIndex: [self.arrayOfCardViewInGrid indexOfObject: item]];
        break;
      }
    }
  }
}



@end

NS_ASSUME_NONNULL_END
