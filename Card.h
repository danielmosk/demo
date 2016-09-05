//
//  Card.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isMatched) BOOL matched;
@property (nonatomic, getter=isChosen) BOOL chosen;

@property (nonatomic) NSUInteger cardsInPlay;

- (int)match:(NSArray *)otherCards;

@end
