//
//  SetCardMatchingGame.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/30.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetCardMatchingGame.h"

#import "SetCard.h"


@implementation SetCardMatchingGame


- (NSInteger)matchScore: (NSArray *)allCards {
  if ([allCards count] == 3) {
    SetCard *firstCard = (SetCard *)allCards[0];
    SetCard *middleCard = (SetCard *)allCards[1];
    SetCard *lastCard = (SetCard *)allCards[2];
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

#define kMATCH_BONUS 10
#define kMISMATCH_PENALTY 3

- (NSInteger)applyBonusses: (NSInteger)matchScore {
  if (matchScore > 0) {
    return (matchScore * kMATCH_BONUS);
  } else {
    return (-kMISMATCH_PENALTY);
  }
}





@end
