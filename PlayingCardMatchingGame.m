//
//  PlayingCardMatchingGame.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 24/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import "PlayingCardMatchingGame.h"

#import "PlayingCard.h"


@implementation PlayingCardMatchingGame


- (NSInteger)matchScore: (NSArray *)allCards {
  if ([allCards count] <= 1) {
    return 0;
  } else {
    PlayingCard *card = [allCards firstObject];
    NSRange range = NSMakeRange(1,[allCards count] - 1);
    NSArray* otherCards = [allCards subarrayWithRange:range];
    for (PlayingCard *otherCard in otherCards) {
      if ([card.suit isEqualToString: otherCard.suit]){
        return ([self matchScore: otherCards] + 1); }
      if (card.rank == otherCard.rank){
        return ([self matchScore: otherCards] + 4); }
    }
  }
  return 0;
}

#define kMATCH_BONUS 4
#define kMISMATCH_PENALTY 2

- (NSInteger)applyBonusses: (NSInteger)matchScore {
  if (matchScore > 0) {
    return (matchScore * kMATCH_BONUS);
  } else {
    return (-kMISMATCH_PENALTY);
  }
}



@end
