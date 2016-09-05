//
//  Card.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    return 1;
}

-(NSUInteger) cardsInPlay {
    if (!_cardsInPlay)
        _cardsInPlay=2;
    return _cardsInPlay;
}

@end
