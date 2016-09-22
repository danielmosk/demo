//
//  SetCardView.m
//  MyCheeseMiaow
//
//  Created by Daniel Moskovich on 2016/09/08.
//  Copyright © 2016年 Daniel Moskovich. All rights reserved.
//

#import "SetCardView.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"


@implementation SetCardView


#pragma mark - inits
#pragma mark -


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

#define CORNER_RADIUS 0.17

- (void)drawRect: (CGRect)rect {
  UIBezierPath *roundedRect = [UIBezierPath
                               bezierPathWithRoundedRect:self.bounds
                               cornerRadius: CORNER_RADIUS * self.bounds.size.width];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [roundedRect stroke];
  [self drawSymbols];
}

- (UIColor *)strokeColour {
  switch (self.colour) {
    case 0:
      return [UIColor redColor];
    case 1:
      return [UIColor greenColor];
    case 2:
      return [UIColor blueColor];
  }
  return [UIColor blackColor];
}

#define SYMBOL_HSHIFT 0.2
#define SYMBOL_LINEWIDTH 0.02

- (void)drawSymbols {
  CGFloat hoffset= self.bounds.size.width * SYMBOL_HSHIFT;
  CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
  switch (self.number){
    case 0:
      [self drawSuitAtPoint:centerPoint];
      return;
    case 1:
      [self drawSuitAtPoint:CGPointMake(centerPoint.x + (hoffset * 3 / 4), centerPoint.y)];
      [self drawSuitAtPoint:CGPointMake(centerPoint.x - (hoffset * 3 / 4), centerPoint.y)];
      return;
    case 2:
      [self drawSuitAtPoint:CGPointMake(centerPoint.x + hoffset * 4 / 3, centerPoint.y)];
      [self drawSuitAtPoint:CGPointMake(centerPoint.x - hoffset * 4 / 3, centerPoint.y)];
      [self drawSuitAtPoint:centerPoint];
      return;
    default:
      return;
  }
}

- (void) drawSuitAtPoint: (CGPoint)point {
  switch (self.suit) {
    case 0:
      [self drawSquiggleAtPoint: point];
      return;
    case 1:
      [self drawOvalAtPoint: point];
      return;
    case 2:
      [self drawDiamondAtPoint: point];
      return;
    default:
      return;
  }
  
}


#define OVAL_WIDTH 0.15
#define OVAL_HEIGHT 0.4

- (void)drawOvalAtPoint: (CGPoint)point {
  CGFloat hoffset = self.bounds.size.width * OVAL_WIDTH / 2.0;
  CGFloat voffset = self.bounds.size.height * OVAL_HEIGHT / 2.0;
  UIBezierPath *path = [UIBezierPath
                        bezierPathWithOvalInRect: CGRectMake(point.x - hoffset, point.y - voffset,
                                                             hoffset * 2.0, voffset * 2.0)];
  [[self strokeColour] setStroke];
  path.lineWidth = self.bounds.size.width * SYMBOL_LINEWIDTH;
  [self striper: path];
  [path stroke];
}

#define DIAMOND_WIDTH 0.22
#define DIAMOND_HEIGHT 0.4

- (void) drawDiamondAtPoint: (CGPoint)point {
  CGFloat hoffset = self.bounds.size.width * DIAMOND_WIDTH / 2.0;
  CGFloat voffset = self.bounds.size.height * DIAMOND_HEIGHT / 2.0;
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [[self strokeColour] setStroke];
  [path moveToPoint: CGPointMake (point.x, point.y - voffset)];
  [path addLineToPoint: CGPointMake (point.x + hoffset, point.y)];
  [path addLineToPoint: CGPointMake(point.x, point.y + voffset)];
  [path addLineToPoint: CGPointMake(point.x - hoffset, point.y)];
  [path closePath];
  path.lineWidth = self.bounds.size.width * SYMBOL_LINEWIDTH;
  [self striper: path];
  [path stroke];
}

#define SQUIGGLE_WIDTH 0.13
#define SQUIGGLE_HEIGHT 0.25
#define SQUIGGLE_BULGE 0.9

- (void) drawSquiggleAtPoint: (CGPoint) point {
  CGFloat hoffset = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
  CGFloat voffset = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
  CGFloat hbulge = hoffset * SQUIGGLE_BULGE;
  CGFloat vbulge = hoffset * SQUIGGLE_BULGE;
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [[self strokeColour] setStroke];
  [path moveToPoint: CGPointMake (point.x - hoffset, point.y - voffset)];
  [path addQuadCurveToPoint:CGPointMake(point.x + hoffset, point.y - voffset)
               controlPoint: CGPointMake(point.x - hbulge, point.y - voffset - vbulge)];
  [path addCurveToPoint: CGPointMake(point.x + hoffset, point.y + voffset)
          controlPoint1: CGPointMake(point.x + hoffset + hbulge , point.y - voffset + vbulge)
          controlPoint2: CGPointMake(point.x + hoffset - hbulge, point.y + voffset - vbulge)];
  [path addQuadCurveToPoint: CGPointMake(point.x - hoffset, point.y + voffset)
               controlPoint: CGPointMake(point.x + hbulge, point.y + voffset + vbulge )];
  [path addCurveToPoint: CGPointMake(point.x - hoffset, point.y - voffset)
          controlPoint1: CGPointMake(point.x - hoffset - hbulge, point.y + voffset- vbulge)
          controlPoint2: CGPointMake(point.x - hoffset + hbulge , point.y - voffset + vbulge)];
  [path closePath];
  path.lineWidth = self.bounds.size.width * SYMBOL_LINEWIDTH;
  [self striper: path];
  [path stroke];
}

#define STRIPE_GAP 0.05
#define STRIPE_FACTOR 7

- (void) striper: (UIBezierPath *)path {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  switch (self.shading) {
    case 0:
      [[self strokeColour] setFill];
      [path fill];
      break;
    case 1: {
      [path addClip];
      [[UIColor colorWithRed: 50.0 / 255.0 green: 200.0 / 255.0 blue: 111.0 / 255.0
                       alpha: 0.03] setFill];
      [path fill];
      UIBezierPath *stripes = [[UIBezierPath alloc] init];
      CGPoint start = self.bounds.origin;
      CGPoint end = start;
      CGFloat voffset = self.bounds.size.height * STRIPE_GAP;
      end.x += self.bounds.size.width;
      start.y += voffset * STRIPE_FACTOR;
      for (int i = 0; i < 1 / STRIPE_GAP; i++)
      {
        [stripes moveToPoint: start];
        [stripes addLineToPoint: end];
        start.y += voffset;
        end.y += voffset;
      }
      [[UIColor blackColor] setStroke];
      [stripes stroke];
      CGContextRestoreGState(UIGraphicsGetCurrentContext());
      break;
    }
    case 2:
      [[UIColor colorWithRed: 50.0 / 255.0 green: 200.0 / 255.0 blue: 111.0 / 255.0
                       alpha: 0.08] setFill];
      [path fill];
      break;
    default:
      break;
  }
}

@end
