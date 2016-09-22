// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.

#import "SetCardMatchingStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardMatchingStrategy

- (NSUInteger)homogeneityMeasure: (NSArray *)cardsToMatch {
  if ([cardsToMatch count] == 3) {
    SetCard *firstCard = (SetCard *)cardsToMatch[0];
    SetCard *middleCard = (SetCard *)cardsToMatch[1];
    SetCard *lastCard = (SetCard *)cardsToMatch[2];
    if (((firstCard.number + middleCard.number + lastCard.number) % 3 == 0) &&
        ((firstCard.colour + middleCard.colour + lastCard.colour) % 3 == 0) &&
        ((firstCard.shading + middleCard.shading + lastCard.shading) % 3 == 0) &&
        ((firstCard.suit + middleCard.suit + lastCard.suit) % 3 == 0))
    {
      return 1;
    }
  }
  return 0;
}

@end

NS_ASSUME_NONNULL_END
