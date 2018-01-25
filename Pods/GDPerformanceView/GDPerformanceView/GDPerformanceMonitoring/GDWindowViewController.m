//
// Copyright © 2017 Gavrilov Daniil
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "GDWindowViewController.h"

@interface GDWindowViewController ()

@property (nonatomic) BOOL selectedStatusBarHidden;

@property (nonatomic) UIStatusBarStyle selectedStatusBarStyle;

@end

@implementation GDWindowViewController

#pragma mark -
#pragma mark - Init Methods & Superclass Overriders

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setSelectedStatusBarHidden:NO];
        [self setSelectedStatusBarStyle:UIStatusBarStyleDefault];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return self.selectedStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedStatusBarStyle;
}

#pragma mark -
#pragma mark - Public Methods

- (void)configureStatusBarAppearanceWithPrefersStatusBarHidden:(BOOL)prefersStatusBarHidden preferredStatusBarStyle:(UIStatusBarStyle)preferredStatusBarStyle {
    self.selectedStatusBarHidden = prefersStatusBarHidden;
    self.selectedStatusBarStyle = preferredStatusBarStyle;
}

@end
