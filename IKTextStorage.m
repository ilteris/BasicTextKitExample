//
//  IKTextStorage.m
//  TextKitExample
//
//  Created by ilteris on 10/8/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "IKTextStorage.h"


NSString *const ATPDefaultTokenName = @"ATPDefaultTokenName";
@interface IKTextStorage ()
{
    NSMutableAttributedString *_backingStore;
    BOOL _dynamicTextNeedsUpdate;
    
}
@end


@implementation IKTextStorage




- (id)init
{
    self = [super init];
    if (self) {
        _backingStore = [[NSMutableAttributedString alloc] init];
    }
    return self;
}

- (NSString *)string
{
    return [_backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    // NSLog(@"range is: %@", NSStringFromRange(range));
    return [_backingStore attributesAtIndex:location effectiveRange:range];
    
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [self beginEditing];
    [_backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters|NSTextStorageEditedAttributes range:range changeInLength:str.length - range.length];
    _dynamicTextNeedsUpdate = YES;
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    //NSLog(@"setAttributes is: %@", NSStringFromRange(range));
    
    [self beginEditing];
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

- (void)performReplacementsForCharacterChangeInRange:(NSRange)changedRange
{
    //NSLog(@"range is: %@", NSStringFromRange(changedRange));
    
    NSRange extendedRange = NSUnionRange(changedRange, [[_backingStore string] lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    //NSLog(@"performReplacementsForCharacterChangeInRange is: %@", NSStringFromRange(extendedRange));
    
    [self applyTokenAttributesToRange:extendedRange];
}



-(void)processEditing
{
    if(_dynamicTextNeedsUpdate)
    {
        _dynamicTextNeedsUpdate = NO;
        [self performReplacementsForCharacterChangeInRange:[self editedRange]];
    }
    [super processEditing];
}



- (void)applyTokenAttributesToRange:(NSRange)searchRange
{
    NSDictionary *defaultAttributes = [self.tokens objectForKey:defaultTokenName];
    
    [[_backingStore string] enumerateSubstringsInRange:searchRange options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        // NSLog(@"substring is %@", substring);
        // NSLog(@"enclosingRange is %@", NSStringFromRange(enclosingRange));
        NSDictionary *attributesForToken = [self.tokens objectForKey:substring];
        //NSLog(@"attributesForToken is %@", attributesForToken);
        if(!attributesForToken)
            attributesForToken = defaultAttributes;
        
        if(attributesForToken)
            [self addAttributes:attributesForToken range:substringRange];
    }];
}



@end
