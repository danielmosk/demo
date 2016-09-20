//
//  SetCard.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/29.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (id)init {
  self= [super init];
  return self;
}


- (void)setNumber: (NSUInteger)rank {
  if (rank) {
    _number = rank % 3;
  }
}

- (void)setColour:(NSUInteger)rank {
  if (rank) {
    _colour = (rank / 3) % 3;
  }
}

- (void)setShading:(NSUInteger)rank {
  if (rank) {
    _shading = (rank / 9) % 3;
  }
}

- (void)setSuit:(NSUInteger)rank {
  if (rank) {
    _suit= (rank / 27) % 3;
  }
}


+ (NSUInteger)maxRank {
  return 81;
}

- (NSUInteger)numberOfCards {
  return [SetCard maxRank];
}

- (NSString *)contents {
  return [NSString stringWithFormat: @"%lu",
          [self integerContents]];
}

- (NSUInteger)integerContents {
  return (self.number + (3 * self.colour) + (9 * self.shading) + (27 * self.suit));
}


@end
