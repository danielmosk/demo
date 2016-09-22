//
//  PlayingCardGameViewController.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/29.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "PlayingCardGameViewController.h"

#import "CardMatchingGameProvider.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCardMatchingStrategy.h"
#import "PlayingCardView.h"


@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

@synthesize game = _game;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setAutoresizingMask: UIViewAutoresizingFlexibleWidth
   | UIViewAutoresizingFlexibleHeight];
  self.maxCardSize = CGSizeMake(80.0, 120.0);
}

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (PlayingCardMatchingStrategy *)createStrategy {
  return [[PlayingCardMatchingStrategy alloc] init];
}

- (NSString *)cardDeckIcon {
  return @"carddeck";
}

#define INITIAL_NUMBER_OF_CARDS 20

- (CardMatchingGame *)game {
  if (!_game) {
    CardMatchingGameProvider *gameParameters = [[CardMatchingGameProvider alloc]
                                                initWithDeck: [self createDeck]
                                                andInitialNumOfCards: INITIAL_NUMBER_OF_CARDS
                                                andMatchBonus: 4
                                                andStrategy: [self createStrategy]
                                                andMismatchPenalty: 2
                                                andNumberOfCardsInMatchedSet: 2
                                                andRemoveWhenMatched: YES];
    _game = [[CardMatchingGame alloc] initWithProvider: gameParameters];
  }
  return _game;
}

- (PlayingCardView *)createViewForCard: (Card *)card {
  PlayingCardView *view = [[PlayingCardView alloc] init];
  [self updateView: view forCard: card];
  return view;
}

- (void) updateView: (UIView *)view forCard: (Card *)card {
  if (![card isKindOfClass: [PlayingCard class]]) return;
  if (![view isKindOfClass: [PlayingCardView class]]) return;
  ((PlayingCardView *)view).rank = ((PlayingCard *)card).rank;
  ((PlayingCardView *)view).suit = ((PlayingCard *)card).suit;
  [view setBackgroundColor: [UIColor clearColor]];
  if (((PlayingCardView *)view).faceUp != ((PlayingCard *)card).chosen) {
    [super animateCardFlip:view];
    ((PlayingCardView *)view).faceUp = ((PlayingCard *)card).chosen;
  }
}

@end
