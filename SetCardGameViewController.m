//
//  SetCardGameViewController.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/30.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetCardGameViewController.h"

#import "SetCardDeck.h"
#import "SetCardMatchingGame.h"
#import "SetCardView.h"


@implementation SetCardGameViewController

@synthesize game = _game;


- (void)viewDidLoad {
  [super viewDidLoad];
  self.maxCardSize = CGSizeMake(80.0, 80.0);
}


- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (NSString *)cardDeckIcon {
  return @"setcarddeck";
}


#define INITIAL_NUMBER_OF_CARDS 15

- (CardMatchingGame *)game {
  if (!_game)
  {
    CardMatchingGameProvider *gameParameters = [[CardMatchingGameProvider alloc]
                                                initWithDeck: [self createDeck]
                                                andInitialNumOfCards: INITIAL_NUMBER_OF_CARDS
                                                andNumberOfCardsInMatchedSet: 3
                                                andRemoveWhenMatched: NO];
    _game = [[SetCardMatchingGame alloc] initWithProvider: gameParameters];
  }
  return _game;
}


- (UIView *)createViewForCard: (Card *)card {
  SetCardView *view = [[SetCardView alloc] init];
  [self updateView:view forCard: card];
  return view;
}

- (void) updateView: (UIView *)view forCard: (Card *)card {
  if (![card isKindOfClass: [SetCard class]]) return;
  if (![view isKindOfClass: [SetCardView class]]) return;
  ((SetCardView *)view).suit = ((SetCard *)card).suit;
  ((SetCardView *)view).number = ((SetCard *)card).number;
  ((SetCardView *)view).colour = ((SetCard *)card).colour;
  ((SetCardView *)view).shading = ((SetCard *)card).shading;
  if (card.chosen) {
    [view setBackgroundColor: [UIColor orangeColor]];
  } else {
    [view setBackgroundColor: [UIColor clearColor]];
  }
}

@end
