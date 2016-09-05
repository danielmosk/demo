//
//  ViewController.h
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//
// Abstract class. Must implement as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController

//protected
-(Deck *)createDeck; //abstract

@end

