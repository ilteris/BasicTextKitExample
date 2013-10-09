//
//  IKViewController.m
//  TextKitExample
//
//  Created by ilteris on 10/8/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "IKViewController.h"
#import "IKTextStorage.h"
#import "IKLayoutManager.h"
@interface IKViewController ()

@property (nonatomic, strong) IKTextStorage *textStorage;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation IKViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.textStorage = [[IKTextStorage alloc] init];
    
    IKLayoutManager *layoutManager = [[IKLayoutManager alloc] init];
    
    NSTextContainer *container = _textView.textContainer;
    
    [layoutManager addTextContainer:container];
    [_textStorage addLayoutManager:layoutManager];
    
    
    [_textStorage beginEditing];
    [_textStorage setAttributedString:self.textView.attributedText];
    
    NSRange range = NSMakeRange(320, 16);
    
    NSDictionary *attributes = @{IKSpecialHighlightAttributeName : [UIColor redColor]};
    
    
    [_textStorage addAttributes:attributes range:range];
    
    [_textStorage endEditing];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    [_textView addGestureRecognizer:singleTap];
    
}


- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    IKLayoutManager *layoutManager = (IKLayoutManager*)_textStorage.layoutManagers[0];
    CGPoint location = [gestureRecognizer locationInView:_textView];
    NSUInteger characterIndex;
    
    characterIndex = [layoutManager characterIndexForPoint:location inTextContainer:_textView.textContainer  fractionOfDistanceBetweenInsertionPoints:NULL];
    NSLog(@"characterIndex is %i", characterIndex);
    
    if(characterIndex > 340 && characterIndex < 380)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Clicked the highlight" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        
        [alertView show];
        
        //remove the observer for the device orientation here, just note to bring it back when we come back to this viewcontroller.
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
