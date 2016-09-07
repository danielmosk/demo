//
//  SetCardGameViewController.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/08/30.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetMatchingGame.h"
#import "HistoryViewController.h"

@interface SetCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CardButtons;
@property (weak, nonatomic) IBOutlet UITextView *eventLabel;
@property (weak, nonatomic) IBOutlet UIButton *RedealButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int scoreCount;
@property (strong, nonatomic) SetMatchingGame *game;
@property (nonatomic, readwrite) NSMutableArray *cardTripleHistory; //of NSAttributedString
@property (nonatomic, readwrite) NSMutableArray *scoreChangeHistory; //of NSNumber

@end

@implementation SetCardGameViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"View History"] ){
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]){
            HistoryViewController *historyvc = (HistoryViewController *)segue.destinationViewController;
            historyvc.cardHistory= self.cardTripleHistory;
            historyvc.scoreHistory=self.scoreChangeHistory;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _game = [[SetMatchingGame alloc] initWithCardCount:[self.CardButtons count]
                                             usingDeck:[self createDeck]];
    self.scoreLabel.text = @"Score: 0";
    for (UIButton *cardButton in self.CardButtons)
    {
        NSUInteger cardButtonIndex = [self.CardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
}

- (SetMatchingGame *)game {
    if (!_game)
        _game = [[SetMatchingGame alloc] initWithCardCount:[self.CardButtons count]
                                                  usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSMutableArray *)cardTripleHistory
{
    if (!_cardTripleHistory) _cardTripleHistory = [[NSMutableArray alloc] init];
    return _cardTripleHistory;
}

- (NSMutableArray *)scoreChangeHistory
{
    if (!_scoreChangeHistory) _scoreChangeHistory = [[NSMutableArray alloc] init];
    return _scoreChangeHistory;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.CardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)touchRedealButton:(UIButton *)sender {
    _game = [[SetMatchingGame alloc] initWithCardCount:[self.CardButtons count]
                                              usingDeck:[self createDeck]];
    self.scoreLabel.text = @"Score: 0";
    for (UIButton *cardButton in self.CardButtons)
    {
        NSUInteger cardButtonIndex = [self.CardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
}


- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *title;
    UIColor *color;
    int number=-1;
    int colour=-1;
    int shading=-1;
    int suit=-1;
    
   if ([card isKindOfClass:[SetCard class]]) {
        number= [card.contents intValue]%3;
        colour= ([card.contents intValue]/3)%3;
        shading= ([card.contents intValue]/9)%3;
        suit= ([card.contents intValue]/27)%3;
    }
    
    switch (suit){
        case 0:
            title= @"●";
            break;
        case 1:
            title= @"■";
            break;
        case 2:
            title= @"▲";
            break;
        default:
            title= @"?";
            break;
    }
    
    switch (colour){
        case 0:
            color = [[UIColor greenColor ] colorWithAlphaComponent:0.3*(number+1)];
            break;
        case 1:
            color = [[UIColor redColor ] colorWithAlphaComponent:0.3*(number+1)];
            break;
        case 2:
            color = [[UIColor blueColor] colorWithAlphaComponent:0.3*(number+1)];
            break;
        default:
            color= [UIColor blackColor];
            }
    
    NSMutableDictionary *stringAttributes = [NSMutableDictionary dictionary];
    
    [stringAttributes setObject: color forKey: NSForegroundColorAttributeName];
    [stringAttributes setObject: [NSNumber numberWithFloat: -2.0*shading] forKey: NSStrokeWidthAttributeName];
    
    
    NSAttributedString *titleSymbolString =[[NSAttributedString alloc] initWithString: title
                                           attributes:stringAttributes];

    return titleSymbolString;
}

- (void) updateUI {
    for (UIButton *cardButton in self.CardButtons)
    {
        NSUInteger cardButtonIndex = [self.CardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        cardButton.enabled = !card.isChosen;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", (int)self.game.score];
    if ([self.game.allCards count] ==3 ){
        
        NSAttributedString *temp1 = [[NSAttributedString alloc] initWithString:@", "];
        NSAttributedString *temp2 = [[NSAttributedString alloc] initWithString:@", and "];
        NSAttributedString *temp3 = [[NSAttributedString alloc] init];
        if (self.game.scorechange>0)
        {
            temp3 =[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" matched for %i points!", (int)self.game.scorechange]];
        }
        else
        {
            temp3 =[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" is a mismatch. Lose %i points.", (int)self.game.scorechange]];;
        }
        
        NSMutableAttributedString *textOnLabel= [[NSMutableAttributedString alloc] init];
        [textOnLabel appendAttributedString:[self titleForCard:self.game.allCards[0]]];
        [textOnLabel appendAttributedString:temp1];
        [textOnLabel appendAttributedString:[self titleForCard:self.game.allCards[1]]];
        [textOnLabel appendAttributedString:temp2];
        [textOnLabel appendAttributedString:[self titleForCard:self.game.allCards[2]]];
        [textOnLabel appendAttributedString:temp3];
        
        self.eventLabel.attributedText = textOnLabel;
        
        NSMutableArray *tripleOfCards = [[NSMutableArray alloc] initWithCapacity:3];
        [tripleOfCards addObject:[self titleForCard:self.game.allCards[0]]];
        [tripleOfCards addObject:[self titleForCard:self.game.allCards[1]]];
        [tripleOfCards addObject:[self titleForCard:self.game.allCards[2]]];
        [self.cardTripleHistory addObject:tripleOfCards];
        [self.scoreChangeHistory addObject:[NSNumber numberWithInteger:(int)self.game.scorechange]];

    }
}

@end
