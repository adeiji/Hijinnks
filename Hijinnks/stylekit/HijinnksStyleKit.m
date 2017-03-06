//
//  HijinnksStyleKit.m
//  Hijinnks
//
//  Created by Adebayo Ijidakinro on 3/4/17.
//  Copyright (c) 2017 Dephyned. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "HijinnksStyleKit.h"


@implementation HijinnksStyleKit

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawMapButtonWithFrame: (CGRect)frame
{
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 0.427 green: 0.602 blue: 0.82 alpha: 1];
    UIColor* fillColor2 = [UIColor colorWithRed: 0.105 green: 0.505 blue: 0.371 alpha: 1];


    //// Subframes
    CGRect worldwidesvgGroup = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));


    //// worldwide.svg Group
    {
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(worldwidesvgGroup) + floor(CGRectGetWidth(worldwidesvgGroup) * 0.00000 + 0.5), CGRectGetMinY(worldwidesvgGroup) + floor(CGRectGetHeight(worldwidesvgGroup) * 0.00000 + 0.5), floor(CGRectGetWidth(worldwidesvgGroup) * 1.00000 + 0.5) - floor(CGRectGetWidth(worldwidesvgGroup) * 0.00000 + 0.5), floor(CGRectGetHeight(worldwidesvgGroup) * 1.00000 + 0.5) - floor(CGRectGetHeight(worldwidesvgGroup) * 0.00000 + 0.5))];
        [fillColor setFill];
        [ovalPath fill];


        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.75667 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.07734 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.76219 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.07426 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.75876 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.07662 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.76045 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.07541 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.50000 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.00000 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.68595 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.02721 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.59617 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.00000 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.21545 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.08895 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.39424 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.00000 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.29622 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.03291 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.21731 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.09483 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.21588 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.09095 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.21643 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.09293 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.37022 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.32178 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.25141 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.16831 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.29529 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.29303 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.47486 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.34740 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.40666 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.33574 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.44033 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.33048 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.48626 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.35679 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.47855 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.34919 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.48395 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.35340 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.51112 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.42929 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.50381 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.38247 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.49371 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.42009 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.52684 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.46588 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.52490 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.43657 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.53272 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.45145 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.57947 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.63847 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.50283 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.52481 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.52360 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.59221 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.55298 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.80571 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.61878 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.67102 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.58605 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.74647 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.58509 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.84324 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.54116 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.82690 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.56224 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.85136 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.68578 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.78195 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.62122 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.83038 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.65114 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.81174 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.79664 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.65502 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.73600 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.73876 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.74686 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.69169 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.79783 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.65347 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.79719 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.65462 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.79760 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.65412 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.81019 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.51398 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.81055 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.61616 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.85009 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.53472 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.72267 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.40045 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.77295 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.49464 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.75902 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.43862 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.70657 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.39312 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.71850 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.39607 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.71257 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.39390 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.61200 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.37603 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.66202 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.38738 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.64198 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.35350 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.55648 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.35566 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.58955 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.39291 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.56431 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.38264 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.53328 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.33403 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.55393 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.34686 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.54943 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.33902 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.51945 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.30429 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.52100 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.33026 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.51503 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.31634 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.51964 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.30376 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.51952 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.30412 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.51957 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.30393 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.47531 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.29293 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.52555 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.28766 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.49224 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.29010 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.48138 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.27767 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.47057 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.29372 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.48667 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.27457 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.43581 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.24459 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.46055 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.28997 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.43471 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.26874 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.48352 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.21643 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.43695 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.22009 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.44152 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.22126 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.54916 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.26243 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.52872 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.19538 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.55060 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.21072 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.57845 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.22538 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.57710 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.26657 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.58686 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.25422 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.58331 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.20060 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.57598 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.21695 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.57797 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.20755 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.75667 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.07734 * CGRectGetHeight(worldwidesvgGroup)) controlPoint1: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.63483 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.13360 * CGRectGetHeight(worldwidesvgGroup)) controlPoint2: CGPointMake(CGRectGetMinX(worldwidesvgGroup) + 0.67784 * CGRectGetWidth(worldwidesvgGroup), CGRectGetMinY(worldwidesvgGroup) + 0.10440 * CGRectGetHeight(worldwidesvgGroup))];
        [bezierPath closePath];
        bezierPath.miterLimit = 4;

        [fillColor2 setFill];
        [bezierPath fill];
    }
}

@end