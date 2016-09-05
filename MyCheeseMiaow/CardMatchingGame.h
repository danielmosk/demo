//
//  CardMatchingGame.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 24/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCard.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger) count
                        usingDeck:(Deck *) deck;

//- (instancetype)setMode:(NSUInteger)inmode;

-(void)chooseCardAtIndex:(NSUInteger) index;
-(Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger scorechange;
@property (nonatomic) NSUInteger mode;
@property (nonatomic, strong) NSArray *allCards; //of cards

@end
