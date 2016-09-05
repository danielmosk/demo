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

- (void) setHistory:(NSArray *)history
{
    _history = history;
    if (self.view.window) [self updateUI];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


- (void) updateUI {
    NSMutableAttributedString *textOnLabel= [[NSMutableAttributedString alloc] init];
    int historyLength= (int)[self.history count];
    if (historyLength==1)
        {
            [textOnLabel appendAttributedString:self.history[0]];
            [textOnLabel deleteCharactersInRange:
            [textOnLabel.string rangeOfComposedCharacterSequenceAtIndex:textOnLabel.length - 1]];
            NSAttributedString *period = [[NSAttributedString alloc] initWithString:@"."];
            [textOnLabel appendAttributedString:period];
        }
        else
        {
            if (historyLength>1)
            {
            for (int i=0; i<historyLength-1; i++)
            {
                NSAttributedString *historyItemNumber = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @"%i: ", i+1]];
                [textOnLabel appendAttributedString:historyItemNumber];
                    [textOnLabel appendAttributedString:self.history[i]];
                    [textOnLabel deleteCharactersInRange:
                     [textOnLabel.string rangeOfComposedCharacterSequenceAtIndex:textOnLabel.length - 1]];
                    NSAttributedString *period = [[NSAttributedString alloc] initWithString:@".\r\r"];
                    [textOnLabel appendAttributedString:period];
                    [textOnLabel addAttributes: @{NSBackgroundColorAttributeName : [UIColor lightGrayColor]} range:NSMakeRange(0,[textOnLabel length])];
            }
                NSAttributedString *historyItemNumber = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @"%i: ", historyLength]];
                [textOnLabel appendAttributedString:historyItemNumber];
                [textOnLabel appendAttributedString:self.history[historyLength-1]];
                [textOnLabel deleteCharactersInRange:
                 [textOnLabel.string rangeOfComposedCharacterSequenceAtIndex:textOnLabel.length - 1]];
                NSAttributedString *period = [[NSAttributedString alloc] initWithString:@"."];
                [textOnLabel appendAttributedString:period];
                
        }
    }
    
        self.body.attributedText = textOnLabel;
}


@end
