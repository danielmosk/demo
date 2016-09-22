//
//  PlayingCardDeck.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import "PlayingCardDeck.h"



@implementation PlayingCardDeck

- (instancetype)init {
  if (self = [super init]) {
    for (NSString *suit in [PlayingCard validSuits]) {
      for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
        PlayingCard *card = [[PlayingCard alloc] init];
        card.rank= rank;
        card.suit = suit;
        [self addCard: card];
      }
    }
  }
  return self;
}




@end
