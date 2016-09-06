//
//  ViewController.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

// Assigment 1 code:
//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
//@property (nonatomic) NSString *cardText;
//@property (strong, nonatomic) Deck *deck;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UISwitch *NMatchModeSwitch;
@property (nonatomic) int scoreCount;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation ViewController


- (IBAction)touchNMatchModeSwitch:(UISwitch *)sender {
    if([sender isOn]){
        self.game.mode=2;
    } else{
        self.game.mode=3;
    }
}

-(CardMatchingGame *)game {
    if (!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    //[self touchNMatchModeSwitch:self.NMatchModeSwitch];
    return _game;
}

-(Deck *)createDeck { //abstract
    return nil;
}
	
// Assignment 1 code:
//- (void)setFlipCount:(int)flipCount
// {
// _flipCount = flipCount;
// self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
// NSLog(@"flipCount changed to %d.",  self.flipCount);
// }

- (IBAction)touchRedealButton:(UIButton *)sender
{
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    self.scoreLabel.text = @"Score: 0";
    for (UIButton *cardButton in self.cardButtons)
    {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    if([self.NMatchModeSwitch isOn]){
        self.game.mode=2;
    } else{
        self.game.mode=3;
    }
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void) updateUI {
    for (UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal ];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", (int)self.game.score];
    if ([self.game.allCards count] >0){
      NSString *setOfCards = @"";
      for (Card *card in self.game.allCards)
        setOfCards= [setOfCards stringByAppendingFormat: @"%@, ", card.contents];
      setOfCards = [setOfCards substringToIndex:[setOfCards length] - 2];
      self.eventLabel.text = [NSString stringWithFormat:@"Event: %@ matched for %i points.", setOfCards, (int)self.game.scorechange];
    }
}


- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


//Assigment 1 code:
//    if ([sender.currentTitle length] && (!_deck.isEmpty)){
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
//                        forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//    }
//   else {
//        Card *card = [self.deck drawRandomCard];
//        if (card){
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
//                          forState:UIControlStateNormal];
//        [sender setTitle:[NSString stringWithFormat:@"%@", card.contents] forState:UIControlStateNormal];
 //       }
//    }
//    if (!_deck.isEmpty)                 //Stop flipping when the deck empties
//            self.flipCount++;
//}


@end

