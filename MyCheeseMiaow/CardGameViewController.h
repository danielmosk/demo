//
//  CardGameViewController.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "CardMatchingGame.h"
#import "Deck.h"


/// Parent for card matching game view controllers.

@interface CardGameViewController : UIViewController

/// Creates a deck of cards of the appropriate class.
-(Deck *)createDeck;
/// Creates a reaction of the view to a change in the state of the card.
- (void) updateView: (UIView *)view forCard: (Card *)card;
/// Animates a card flipping over.
- (void)animateCardFlip: (UIView *)view;

/// A library image representing a deck of cards.
@property (strong, nonatomic) NSString *cardDeckIcon;
/// Maximum display size of a card.
@property (nonatomic) CGSize maxCardSize;
/// The card matching game itself (the model).
@property (strong, nonatomic) CardMatchingGame *game;

@end
