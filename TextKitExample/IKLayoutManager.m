//
//  IKLayoutManager.m
//  TextKitExample
//
//  Created by ilteris on 10/8/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "IKLayoutManager.h"

@implementation IKLayoutManager

NSString * const  IKSpecialHighlightAttributeName = @"SpecialHighlightAttribute";


- (void)drawGlyphsForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin {
    NSTextStorage *textStorage = self.textStorage;
    NSRange glyphRange = glyphsToShow;
    while (glyphRange.length > 0) {
        NSRange charRange = [self characterRangeForGlyphRange:glyphRange actualGlyphRange:NULL], attributeCharRange, attributeGlyphRange;
        
        id attribute = [textStorage attribute:IKSpecialHighlightAttributeName
                                      atIndex:charRange.location longestEffectiveRange:&attributeCharRange
                                      inRange:charRange];
        attributeGlyphRange = [self glyphRangeForCharacterRange:attributeCharRange actualCharacterRange:NULL];
        attributeGlyphRange = NSIntersectionRange(attributeGlyphRange, glyphRange);
        if( attribute != nil ) {
            
            NSTextContainer *textContainer = self.textContainers[0];
            CGRect boundingRect = [self boundingRectForGlyphRange:attributeGlyphRange inTextContainer:textContainer];
            [[UIColor whiteColor] setFill]; // set rounded rect's bg color
            
            boundingRect.origin.x += origin.x-3.0;
            boundingRect.origin.y += origin.y-2.0;
            boundingRect.size.width += 6.0;
            boundingRect.size.height += 4.0;
            
            UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:boundingRect cornerRadius: 0.0];
            [roundedRect fillWithBlendMode: kCGBlendModeNormal alpha:1.0f];
            [[UIColor redColor] setStroke]; // set rounded rect's bg color
            
            [roundedRect strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
         
            
            [super drawGlyphsForGlyphRange:attributeGlyphRange atPoint:origin];
        }
        else {
            [super drawGlyphsForGlyphRange:glyphsToShow atPoint:origin];
        }
        glyphRange.length = NSMaxRange(glyphRange) - NSMaxRange(attributeGlyphRange);
        glyphRange.location = NSMaxRange(attributeGlyphRange);
    }
}



@end
