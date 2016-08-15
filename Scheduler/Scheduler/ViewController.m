//
//  ViewController.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/13/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "ViewController.h"
#import "Scheduler.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextView *tasks;
@property (nonatomic, weak) IBOutlet UITextView *resources;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tasks.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tasks.layer.borderWidth = 1.f;
    self.resources.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.resources.layer.borderWidth = 1.f;
    
    [self addToolbars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addToolbars {
    UIToolbar *accessoryView = [[UIToolbar alloc] init];
    
    UIBarButtonItem *doneButton  = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(done)];
    UIBarButtonItem *flexSpace   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:nil
                                                                                 action:nil];
    [accessoryView sizeToFit];
    accessoryView.items = @[flexSpace, doneButton];
    [self.tasks setInputAccessoryView:accessoryView];
    [self.resources setInputAccessoryView:accessoryView];
}

- (void)done {
    [self.view endEditing:YES];
}

- (IBAction)startProcessing {
    
}


@end
