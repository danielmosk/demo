//
//  SetCardDeck.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/29.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
            for (NSUInteger rank =1; rank <= [SetCard maxRank]; rank++)
            {
                SetCard *card = [[SetCard alloc] init];
                card.number=rank;
                card.colour=rank;
                card.shading=rank;
                card.suit = rank;
                [self addCard:card];
            }
        }
    return self;
}

@end
