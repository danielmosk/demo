//
//  PlayingCardView.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/09/08.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "PlayingCardView.h"
#import "PlayingCard.h"


@implementation PlayingCardView


#pragma mark - inits
#pragma mark -


- (void) setFaceUp: (BOOL)faceUp {
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

- (void) setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib {
  [super awakeFromNib];
  [self setup];
}


#pragma mark - Drawing
#pragma mark -

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat) cornerScaleFactor {
  return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat) cornerRadius {
  return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat) cornerOffset {
  return [self cornerRadius] / 3.0;
}

- (void)drawRect:(CGRect)rect {
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect: self.bounds
                                                         cornerRadius: [self cornerRadius]];
  [[UIColor clearColor] setFill];
  UIRectFill(self.bounds);
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  if (self.faceUp) {
    [[UIColor blueColor] setStroke];
    roundedRect.lineWidth *= 2;
  }
  else {
    [[UIColor colorWithWhite: 0.8 alpha: 1.0] setStroke];
    roundedRect.lineWidth /= 2;
  }
  if ([self faceUp]) {
    UIImage *faceImage = [UIImage imageNamed: [NSString stringWithFormat: @"%@%@",
                                               [ self rankAsString], self.suit]];
    if (faceImage) {
      [faceImage drawInRect: self.bounds];
    }
    else {
      [self drawPips];
    }
    [self drawCorners];
  }
  else {
    [[UIImage imageNamed: @"cardback"] drawInRect: self.bounds];
  }
}

- (void) drawCorners {
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]  init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  UIFont *cornerFont = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize: cornerFont.pointSize * [self cornerScaleFactor]];
  NSAttributedString *cornerText = [[NSAttributedString alloc]
                                    initWithString: [NSString stringWithFormat: @"%@\r%@",
                                                     [self rankAsString], self.suit]
                                    attributes: @{ NSFontAttributeName: cornerFont,
                                                   NSParagraphStyleAttributeName: paragraphStyle}];
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  [cornerText drawInRect: textBounds];
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [cornerText drawInRect: textBounds];
}


#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawPips {
  if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
    [self drawPipsWithHorizontalOffset: 0
                        verticalOffset: 0
                    mirroredVertically: NO];
  }
  if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
    [self drawPipsWithHorizontalOffset: PIP_HOFFSET_PERCENTAGE
                        verticalOffset: 0
                    mirroredVertically: NO];
  }
  if ((self.rank == 2) || (self.rank == 3) ||
      (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset: 0
                        verticalOffset: PIP_VOFFSET2_PERCENTAGE * 1.2
                    mirroredVertically: (self.rank != 7)];
  }
  if ((self.rank > 3) && (self.rank < 11)) {
    [self drawPipsWithHorizontalOffset: PIP_HOFFSET_PERCENTAGE
                        verticalOffset: PIP_VOFFSET3_PERCENTAGE * 1.2
                    mirroredVertically: YES];
  }
  if ((self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset: PIP_HOFFSET_PERCENTAGE
                        verticalOffset: PIP_VOFFSET1_PERCENTAGE * 1.2
                    mirroredVertically: YES];
  }
}

#define PIP_FONT_SCALE_FACTOR 0.01

- (void) drawPipsWithHorizontalOffset: (CGFloat)hoffset
                       verticalOffset: (CGFloat)voffset
                           upsideDown: (BOOL)upsideDown {
  if (upsideDown) [self pushContextAndRotateUpsideDown];
  CGPoint middle = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
  UIFont *pipFont = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
  pipFont = [pipFont fontWithSize: [pipFont pointSize]
             * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
  NSAttributedString *attributedSuit = [[NSAttributedString alloc]
                                        initWithString: self.suit
                                        attributes:@{ NSFontAttributeName: pipFont}];
  CGSize pipSize = [attributedSuit size];
  CGPoint pipOrigin = CGPointMake ( middle.x - pipSize.width / 2.0
                                   - hoffset * self.bounds.size.width,
                                   middle.x - pipSize.height / 2.0
                                   + voffset * self.bounds.size.height );
  [attributedSuit drawAtPoint: pipOrigin];
  if (hoffset) {
    pipOrigin.x += hoffset * 2.0 * self.bounds.size.width;
    [attributedSuit drawAtPoint: pipOrigin];
  }
  if (upsideDown) [self popContext];
}

- (void) drawPipsWithHorizontalOffset: (CGFloat)hoffset
                       verticalOffset: (CGFloat)voffset
                   mirroredVertically: (BOOL)mirroredVertically {
  [self drawPipsWithHorizontalOffset: hoffset
                      verticalOffset: voffset
                          upsideDown: NO];
  if (mirroredVertically) {
    [ self drawPipsWithHorizontalOffset: hoffset
                         verticalOffset: voffset
                             upsideDown: YES];
  }
}

-(void)pushContextAndRotateUpsideDown {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextRotateCTM(context, M_PI);
}

-(void) popContext {
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (NSString *)rankAsString {
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

@end
