//
//  SetCardGameViewController.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/30.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface SetCardGameViewController : UIViewController


-(Deck *)createDeck;
@property (nonatomic, readonly) NSMutableArray *cardTripleHistory; //of NSAttributedString
@property (nonatomic, readonly) NSMutableArray *scoreChangeHistory; //of NSNumber

@end
