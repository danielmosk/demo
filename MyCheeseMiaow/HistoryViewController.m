//
//  HistoryViewController.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/09/04.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "HistoryViewController.h"
#import "SetMatchingGame.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *body;



@end

@implementation HistoryViewController

- (void) setCardHistory:(NSArray *)cardHistory
{
    _cardHistory = cardHistory;
    if (self.view.window) [self updateUI];
}

- (void) setScoreHistory:(NSArray *)scoreHistory
{
    _scoreHistory = scoreHistory;
    if (self.view.window) [self updateUI];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}




- (void) updateUI {
    NSMutableAttributedString *textOnLabel= [[NSMutableAttributedString alloc] init];
    int historyLength= (int)[self.cardHistory count];
    NSLog(@"HistoryLength: %i", historyLength);
    
    NSMutableAttributedString *temp1 = [[NSMutableAttributedString alloc] initWithString:@", " attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    NSMutableAttributedString *temp2 = [[NSMutableAttributedString alloc] initWithString:@", and " attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    if (historyLength){
        int i=0;
        while (i+1<historyLength)
        {
            [textOnLabel appendAttributedString:self.cardHistory[i][0]];
            [textOnLabel appendAttributedString:temp1];
            [textOnLabel appendAttributedString:self.cardHistory[i][1]];
            [textOnLabel appendAttributedString:temp2];
            [textOnLabel appendAttributedString:self.cardHistory[i][2]];
            
            if ([self.scoreHistory[i] integerValue]>0)
            {
             NSMutableAttributedString *temp3 =[[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@" were matched for %i points.\r\r", [self.scoreHistory[i] intValue]] attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
                [textOnLabel appendAttributedString:temp3];
            }
            else
            {
                NSMutableAttributedString *temp3 =[[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@" was a mismatch. Lost %i points.\r\r", [self.scoreHistory[i] intValue]] attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
                [textOnLabel appendAttributedString:temp3];
            }
            i++;
        } // end of while loop
        
        [temp1 removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0,temp1.length)];
        [temp2 addAttributes: @{NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(0,temp2.length)];
        
        [textOnLabel appendAttributedString:self.cardHistory[historyLength-1][0]];
        [textOnLabel appendAttributedString:temp1];
        [textOnLabel appendAttributedString:self.cardHistory[historyLength-1][1]];
        [textOnLabel appendAttributedString:temp2];
        [textOnLabel appendAttributedString:self.cardHistory[historyLength-1][2]];
        
        if ([self.scoreHistory[historyLength-1] integerValue]>0)
        {
            NSMutableAttributedString *temp3 =[[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@" were matched for %i points.", [self.scoreHistory[historyLength-1] intValue]] ];
            [textOnLabel appendAttributedString:temp3];
        }
        else
        {
            NSMutableAttributedString *temp3 =[[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@" was a mismatch. Lost %i points.", [self.scoreHistory[historyLength-1] intValue]] ];
            [textOnLabel appendAttributedString:temp3];
        }
        
    }
        self.body.attributedText = textOnLabel;
}


@end
