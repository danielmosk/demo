// Copyright (c) 2016年 Lightricks. All rights reserved.
// Created by Daniel Moskovich.

#import "PlayingCardMatchingStrategy.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardMatchingStrategy

- (NSUInteger)homogeneityMeasure: (NSArray *)cardsToMatch {
  if (([cardsToMatch count] <= 1) ||
      !([[cardsToMatch firstObject] isKindOfClass: [PlayingCard class]])) {
    return 0;
  } else {
    PlayingCard *card = [cardsToMatch firstObject];
    NSMutableArray *tempCards = [cardsToMatch mutableCopy];
    NSRange range = NSMakeRange(1,[cardsToMatch count] - 1);
    NSArray* otherCards = [[NSArray alloc]
                                   initWithArray: [tempCards subarrayWithRange: range]];
    for (PlayingCard *otherCard in otherCards) {
      if ([card.suit isEqualToString: otherCard.suit]){
        return (1 + [self homogeneityMeasure: otherCards]); }
      if (card.rank == otherCard.rank){
        return (4 + [self homogeneityMeasure: otherCards]); }
    }
  }
  return 0;
}

@end

NS_ASSUME_NONNULL_END
