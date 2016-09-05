//
//  Deck.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (nonatomic, getter=isEmpty) BOOL empty;

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
