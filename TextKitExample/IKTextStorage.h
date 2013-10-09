//
//  IKTextStorage.h
//  TextKitExample
//
//  Created by ilteris on 10/8/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import <UIKit/UIKit.h>


NSString *const defaultTokenName;


@interface IKTextStorage : NSTextStorage
@property (nonatomic, copy) NSDictionary *tokens; // a dictionary, keyed by text snippets, with attributes we want to add

@end
