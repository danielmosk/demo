//
//  SetCardDeck.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/29.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetCardDeck.h"


@implementation SetCardDeck

- (instancetype)init {
  if (self = [super init]) {
    for (NSUInteger rank = 0; rank < [SetCard maxRank]; rank++) {
      SetCard *card = [[SetCard alloc] init];
      card.number = rank;
      card.colour = rank;
      card.shading = rank;
      card.suit = rank;
      [self addCard: card];
    }
  }
  return self;
}


@end
