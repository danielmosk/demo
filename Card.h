//
//  Card.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import <Foundation/Foundation.h>


/// The parent class for cards
@interface Card : NSObject

/// Sets a card to "hidden", to remove next turn.
- (void) hideCard;
/// Returns the number of different possible cards of the given class.
- (NSUInteger)numberOfCards;


/// The contents of the card, for display and debugging
@property (strong, nonatomic) NSString *contents;
/// An integer hash of the card contents for internal use.
@property (nonatomic) NSUInteger integerContents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isHidden) BOOL hidden;
@property (nonatomic, getter=isMatched) BOOL matched;

@end
