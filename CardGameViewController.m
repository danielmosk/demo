//
//  CardGameViewController.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 23/08/2016.
//  Copyright © 2016 Daniel Moskovich. All rights reserved.
//

#import "CardGameViewController.h"

#import "arrayOfCardViewInGrid.h"
#import "grid.h"



@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UIButton *addCardsButton;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panRecogniser;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchRecogniser;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UIView *gridView;

@property (strong, nonatomic) UIDynamicAnimator *stackCardsAnimator;

@property (strong, nonatomic) Grid *grid;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (strong, nonatomic) arrayOfCardViewInGrid *cardForCardViewArray;

@property (nonatomic) int scoreCount;

@end

@implementation CardGameViewController

@synthesize cardViews = _cardViews;

#pragma mark - Pure virtual functions
#pragma mark-

- (CardMatchingGame *)game {
  return nil;
}

- (NSString *)cardDeckIcon {
  return nil;
}

- (Deck *)createDeck {
  return nil;
}

- (void)updateView: (UIView *)view forCard: (Card *)card {
}


#pragma mark - inits
#pragma mark-


- (NSMutableArray *)cardViews {
  if (!_cardViews) {
    _cardViews = [NSMutableArray
                  arrayWithCapacity: self.game.gameParameters.initialNumberOfCards];
  }
  return _cardViews;
}

- (arrayOfCardViewInGrid *)cardForCardViewArray {
  if (!_cardForCardViewArray) {
    _cardForCardViewArray = [[arrayOfCardViewInGrid alloc] init];
  }
  return _cardForCardViewArray;
}

- (Grid *)grid {
  if (!_grid) {
    _grid = [[Grid alloc] init];
    _grid.size = self.gridView.frame.size;
    _grid.cellAspectRatio = self.maxCardSize.width / self.maxCardSize.height;
    _grid.minimumNumberOfCells = self.game.gameParameters.initialNumberOfCards;
    _grid.maxCellWidth = self.maxCardSize.width;
    _grid.maxCellHeight = self.maxCardSize.height;
  }
  return _grid;
}

- (void)viewDidLoad {
  [self.addCardsButton setBackgroundImage: [UIImage imageNamed: self.cardDeckIcon]
                                 forState: UIControlStateNormal];
  [self.addCardsButton setTitle: @"" forState:UIControlStateNormal];
  self.addCardsButton.backgroundColor = [UIColor whiteColor];
  [self touchRedealButton: nil];
}


#pragma mark - IBActions
# pragma mark-

#define kINSET 0.15
#define kANIMATION_DURATION 1


- (IBAction)touchRedealButton: (UIButton *)sender {
  for (UIView *cardView in self.cardViews) {
    [self animateRedeal: cardView];
  }
  [self delayCallback:^{
    for (UIView *cardView in self.cardViews) {
      [cardView removeFromSuperview];
    }
    self.game = nil;
    self.cardViews = nil;
    self.grid = nil;
    self.cardForCardViewArray = nil;
    self.addCardsButton.enabled = YES;
    self.addCardsButton.alpha = 1.0;
    self.scoreLabel.text = @"Score: 0";
    self.eventLabel.text = @"Event:";
    [self updateUI];
  } forTotalSeconds: kANIMATION_DURATION];
}


- (IBAction)gatherCardsToStack: (UIPinchGestureRecognizer *)gesture {
  if (gesture.state == UIGestureRecognizerStateChanged ||
      (gesture.state == UIGestureRecognizerStateEnded)) {
    self.panRecogniser.enabled = NO;
    if (!self.stackCardsAnimator) {
      CGPoint center = [gesture locationInView: self.gridView];
      self.stackCardsAnimator = [[UIDynamicAnimator alloc]
                                 initWithReferenceView: self.gridView];
      for (UIView *cardView in self.cardViews) {
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem: cardView
                                                        snapToPoint: center];
        snap.damping = 2.5;
        [self.stackCardsAnimator addBehavior: snap];
        [self delayCallback:^{self.panRecogniser.enabled = YES;}
            forTotalSeconds: 1.3 * kANIMATION_DURATION];
      }
    }
  }
}


- (IBAction)panStack: (UIPanGestureRecognizer *)gesture {
  if (self.stackCardsAnimator) {
    CGPoint center = [gesture locationInView: self.gridView];
    if (gesture.state == UIGestureRecognizerStateBegan) {
      for (UIView *cardView in self.cardViews) {
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]
                                            initWithItem: cardView
                                            attachedToAnchor: center];
        [self.stackCardsAnimator addBehavior: attachment];
        UIDynamicItemBehavior *doNotRotate = [[UIDynamicItemBehavior alloc] init];
        doNotRotate.allowsRotation = NO;
        [self.stackCardsAnimator addBehavior: doNotRotate];
      }
      for (UIDynamicBehavior *behavior in self.stackCardsAnimator.behaviors) {
        if ([behavior isKindOfClass: [UISnapBehavior class]]) {
          [self.stackCardsAnimator removeBehavior: behavior];
        }
      }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
      for (UIDynamicBehavior *behavior in self.stackCardsAnimator.behaviors) {
        if ([behavior isKindOfClass: [UIAttachmentBehavior class]]) {
          ((UIAttachmentBehavior *)behavior).anchorPoint = center;
        }
      }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
      self.panRecogniser.enabled = NO;
      self.stackCardsAnimator = nil;
      [self updateUI];
      
    }
  }
}


- (IBAction)touchAddCardsButton: (UIButton *)sender {
  for (int i = 0; i < 3; i++) {
    [self.game drawCard];
  }
  if (self.game.gameParameters.deck.isEmpty) {
    [self.addCardsButton setBackgroundImage: nil forState: UIControlStateNormal];
    [self.addCardsButton setTitle: @"EMPTY" forState: UIControlStateNormal];
    self.addCardsButton.enabled = NO;
    self.addCardsButton.alpha = 0.5;
  }
  self.stackCardsAnimator = nil;
  [self updateUI];
}

- (void)cleanUpOddsAndEndsFromPreviousTurn {
  if (self.game.gameParameters.removeWhenMatched) {
    [self.game removeHiddenCards];
  } else {
    [self.game deselectPreviouslyMatchedCards];
  }
  [self.game emptyAllCards];
}

- (void)touchCardView: (UITapGestureRecognizer *)tap {
  if (tap.state == UIGestureRecognizerStateEnded && !self.stackCardsAnimator) {
    [self cleanUpOddsAndEndsFromPreviousTurn];
    [self.game chooseCard: [self.cardForCardViewArray cardForView: tap.view]];
    [self updateView: tap.view forCard: [self.cardForCardViewArray cardForView: tap.view]];
    [self updateUI];
  }
}


#pragma mark - UI updates
# pragma mark-


- (NSUInteger)firstEmptyLocation: (NSArray *)array {
  NSMutableArray *arrayOfLocations = [[NSMutableArray alloc] init];
  for (id item in self.cardForCardViewArray) {
    if ([item isKindOfClass: [CardViewInGrid class]]) {
      [arrayOfLocations addObject: @(((CardViewInGrid *) item).gridLocation)];
    }
  }
  NSArray *sortedArray;
  sortedArray = [arrayOfLocations sortedArrayUsingComparator: ^NSComparisonResult(id a, id b) {
    NSNumber *first = a;
    NSNumber *second = b;
    return [first compare:second];
  }];
  for (NSUInteger i = 0; i < [sortedArray count]; i++) {
    if ([sortedArray[i] unsignedIntegerValue] != i)
      return i;
  }
  return [array count];
}


- (UIView *)createViewForCard: (Card *)card {
  UIView *view = [[UIView alloc] init];
  [self updateView: view forCard: card];
  return view;
}

- (void)removeCards: (NSArray *)cardsToRemove {
  for (Card* cardToRemove in cardsToRemove) {
    UIView *cardView = [self.cardForCardViewArray viewForCard: cardToRemove];
    cardView.alpha *= 0.5;
    [cardToRemove hideCard];
    [self.cardViews removeObject:cardView];
    [self.cardForCardViewArray removeEntry:cardToRemove];
    [self animateCardRemoval:cardView];
  }
}

- (void)addCards: (NSArray *)cardsToAdd {
  for (Card* card in cardsToAdd) {
    UIView *cardView = (UIView *)[self createViewForCard: card];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget: self
                                   action: @selector(touchCardView:)];
    [cardView addGestureRecognizer: tap];
    [self.cardViews addObject: cardView];
    [self.gridView addSubview: cardView];
    CardViewInGrid* newViewInGrid = [[CardViewInGrid alloc] init];
    newViewInGrid.cardForView = card;
    newViewInGrid.gridLocation =  [self firstEmptyLocation: self.cardForCardViewArray];
    newViewInGrid.view= cardView;
    [self.cardForCardViewArray addObject: newViewInGrid];
  }
}

- (void)reframeCards {
  self.grid.minimumNumberOfCells = [self.game.cards count];
  NSUInteger animationCounter = 0;
  for (Card* card in self.game.cards) {
    if (!card.hidden) {
      NSUInteger viewLocation = [self.cardForCardViewArray locationForCard: card];
      UIView *cardView = (UIView *)[self.cardForCardViewArray viewForCard: card];
      CGRect frame = [self.grid frameOfCellAtRow: viewLocation / self.grid.columnCount
                                        inColumn: viewLocation % self.grid.columnCount];
      frame = CGRectInset(frame, frame.size.width * kINSET , frame.size.height * kINSET);
      if (!CGRectEqualToRect(cardView.frame, frame)){
        [self animateChangeFrame:cardView toFrame: frame withDelay: 0.06 * (++animationCounter)];
      }
      [self updateView: cardView forCard: card];
    }
  }
}

- (void)updateEventLabel {
  if (self.game.gameParameters.numberOfCardsInMatchedSet ==
      [self.game.allCards count]) {
    NSMutableArray *truncatedHistory = [self.game.matchHistory mutableCopy];
    [truncatedHistory removeLastObject];
    if (![self.game newMatch: truncatedHistory]) {
      self.eventLabel.text = [NSString stringWithFormat: @"Old match..."];
      return;
    }
    NSAttributedString *temp0 = [[NSAttributedString alloc] initWithString: @", "];
    NSAttributedString *temp1 = [[NSAttributedString alloc] init];
    NSAttributedString *temp2 = [[NSAttributedString alloc] init];
    if ([self.game.allCards count]>2) {
      temp1 = [[NSAttributedString alloc] initWithString: @", and "];
    } else {
      temp1 = [[NSAttributedString alloc] initWithString: @" and "];
    }
    if (self.game.scorechange > 0) {
      temp2 = [[NSAttributedString alloc] initWithString:
               [NSString stringWithFormat: @" matched for %i points!",
                (int)self.game.scorechange]];
    }
    else {
      temp2 = [[NSAttributedString alloc] initWithString:
               [NSString stringWithFormat: @" is a mismatch. %i points.",
                (int)self.game.scorechange]];;
    }
    NSMutableAttributedString *textOnLabel = [[NSMutableAttributedString alloc] initWithString:
                                              ((Card *)[self.game.allCards firstObject]).contents];
    for (int i = 1; i < [self.game.allCards count]-1; i++) {
      NSAttributedString *cardContents = [[NSAttributedString alloc]
                                          initWithString: ((Card *)self.game.allCards[i]).contents];
      [textOnLabel appendAttributedString: temp0];
      [textOnLabel appendAttributedString: cardContents];
    }
    [textOnLabel appendAttributedString: temp1];
    NSAttributedString *cardContentsLast = [[NSAttributedString alloc]
                                            initWithString:
                                            ((Card *)[self.game.allCards lastObject]).contents];
    [textOnLabel appendAttributedString: cardContentsLast];
    [textOnLabel appendAttributedString: temp2];
    self.eventLabel.attributedText = textOnLabel;
  }
}

-(void) updateUI {
  NSMutableArray *cardsToAdd = [[NSMutableArray alloc] init];
  NSMutableArray *cardsToRemove = [[NSMutableArray alloc] init];
  for (Card* card in self.game.cards) {
    if (card.hidden) {
      [[self.cardForCardViewArray viewForCard:card] removeFromSuperview];
    } else {
      if (card.matched && self.game.gameParameters.removeWhenMatched) {
        [cardsToRemove addObject: card];
      }
      if (![self.cardForCardViewArray doesThisArray: self.cardForCardViewArray
                                     containTheCard: card]) {
        [cardsToAdd addObject: card];
      }
      if (!self.game.gameParameters.removeWhenMatched && (self.game.scorechange < 0)) {
        [self delayCallback:^{[[self.cardForCardViewArray viewForCard: card]
                               setBackgroundColor: [UIColor clearColor]];
          card.chosen = NO;}
            forTotalSeconds: kANIMATION_DURATION]; }
    }
  }
  [self removeCards: cardsToRemove];
  [self addCards: cardsToAdd];
  [self reframeCards];
  self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", self.game.score];
  [self updateEventLabel];
  
}


# pragma mark - autolayout
# pragma mark-


- (void)viewWillTransitionToSize: (CGSize)size
       withTransitionCoordinator: (id<UIViewControllerTransitionCoordinator>)coordinator {
  [coordinator
   animateAlongsideTransitionInView: self.gridView
   animation: ^(id<UIViewControllerTransitionCoordinatorContext> context)
   {
     self.grid.size = self.gridView.bounds.size;
     self.stackCardsAnimator = nil;
     [self updateUI];
   } completion: nil
   ];
  [super viewWillTransitionToSize: size withTransitionCoordinator: coordinator];
}


# pragma mark- Animations
# pragma mark-

- (void) animateCardRemoval: (UIView *)view {
  [self delayCallback:^{[UIView animateWithDuration:1.5 * kANIMATION_DURATION
                                         animations:^{ view.frame =
                                           CGRectMake(0.0, self.gridView.bounds.size.height,
                                                      self.grid.cellSize.width,
                                                      self.grid.cellSize.height);
                                         }
                                         completion: nil];} forTotalSeconds: kANIMATION_DURATION];
}

- (void)animateCardFlip: (UIView *)view {
  [UIView transitionWithView:view duration: 0.5 * kANIMATION_DURATION
                     options: UIViewAnimationOptionTransitionFlipFromLeft
                  animations: nil completion: nil ];
  [self delayCallback:^{return;}
      forTotalSeconds: 0.5 * kANIMATION_DURATION];
}

- (void)animateChangeFrame: (UIView  *)view toFrame: (CGRect)frame
                 withDelay: (float)animationDelay {
  [UIView animateWithDuration: 0.5 * kANIMATION_DURATION delay: animationDelay
                      options: UIViewAnimationOptionCurveEaseOut
                   animations:^{view.frame = frame;} completion: nil];
}

- (void)animateRedeal: (UIView *)view {
  [UIView animateWithDuration: kANIMATION_DURATION  delay: 0.1 * kANIMATION_DURATION
                      options: UIViewAnimationOptionAutoreverse
                   animations:^{
                     view.frame = CGRectMake(self.gridView.bounds.size.width,
                                             self.gridView.bounds.size.height,
                                             self.grid.cellSize.width,
                                             self.grid.cellSize.height);
                     self.redealButton.enabled = NO;
                   }
                   completion:^(BOOL finished){[self
                                                delayCallback:^{self.redealButton.enabled = YES;}
                                                forTotalSeconds: kANIMATION_DURATION];}];
}

- (void)delayCallback: (void(^)(void))callback forTotalSeconds: (double)delayInSeconds {
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    if(callback){
      callback();
    }
  });
}

@end

