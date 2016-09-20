// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.


#import "arrayOfCardViewInGrid.h"

NS_ASSUME_NONNULL_BEGIN

@implementation arrayOfCardViewInGrid


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
  for (id item in self) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      if ([view isEqual: ((CardViewInGrid *)item).view])
        return ((CardViewInGrid *)item).cardForView;
    }
  }
  return 0;
}


- (UIView *)viewForCard: (Card *)card {
  for (id item in self) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      if ([card isEqual: ((CardViewInGrid *)item).cardForView])
        return ((CardViewInGrid *)item).view;
    }
  }
  return nil;
}

- (NSUInteger)locationForCard: (Card *)card {
  for (id item in self) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      if ([card isEqual: ((CardViewInGrid *)item).cardForView])
        return ((CardViewInGrid *)item).gridLocation;
    }
  }
  return 0;
}


- (void)removeEntry: (Card *)card {
  for (CardViewInGrid* item in self) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      if ([card isEqual: ((CardViewInGrid *)item).cardForView]) {
        [self removeObject: item];
        break;
      }
    }
  }
}

-(instancetype)init {
  if (self = [super init]) {
    _backendArray = [@[] mutableCopy];
  }
  return self;
}

// Super's Required Methods

-(void)addObject:(id)anObject {
  [_backendArray addObject: anObject];
}

-(void)insertObject: (id)anObject atIndex: (NSUInteger)index {
  [_backendArray insertObject: anObject atIndex: index];
}

-(void)replaceObjectAtIndex: (NSUInteger)index withObject: (id)anObject {
  [_backendArray replaceObjectAtIndex: index withObject: anObject];
}

-(id)objectAtIndex: (NSUInteger)index {
  return [_backendArray objectAtIndex: index];
}

-(NSUInteger)count {
  return _backendArray.count;
}

-(void)removeObject: (id)anObject {
  [_backendArray removeObject: anObject];
}

-(void)removeLastObject {
  [_backendArray removeLastObject];
}

-(void)removeAllObjects {
  [_backendArray removeAllObjects];
}

-(void)removeObjectAtIndex:(NSUInteger)index {
  [_backendArray removeObjectAtIndex:  index];
}


@end

NS_ASSUME_NONNULL_END
