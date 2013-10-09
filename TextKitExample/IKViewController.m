//
//  IKViewController.m
//  TextKitExample
//
//  Created by ilteris on 10/8/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "IKViewController.h"
#import "IKTextStorage.h"

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
