//
//  ViewController.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/13/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "ViewController.h"
#import "Scheduler.h"
#import <YAMLThatWorks/YATWSerialization.h>

#define OVERLAY_TAG 99

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

- (void)done {
    [self.view endEditing:YES];
}


#pragma mark - IBActions


- (IBAction)startProcessing {
    if (self.tasks.text.length == 0 || self.resources.text.length == 0) {
        [self showMalformedYAMLError:nil];
        return;
    }
    
    [self showLoadingScreen];
    @try {
        [[Scheduler alloc] initWithTasks:self.tasks.text resources:self.resources.text];
    } @catch (NSError *e) {
        [self showMalformedYAMLError:e];
        return;
    } @finally {
        [self hideLoadingScreen];
    }
}


#pragma mark - UI Helper functions

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

- (void)showLoadingScreen {
    UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
    UIView *v = [[UIView alloc] initWithFrame:mainWindow.bounds];
    v.backgroundColor = [UIColor blackColor];
    v.alpha = 0;
    v.tag = OVERLAY_TAG;
    
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    act.center = v.center;
    act.hidden = NO;
    act.color = [UIColor colorWithWhite:.3f alpha:.7f];
    [v addSubview:act];
    
    [mainWindow addSubview:v];
    
    [UIView animateWithDuration:.3f animations:^{
        v.alpha = .5;
    } completion:^(BOOL finished) {
        [act startAnimating];
    }];
}

- (void)hideLoadingScreen {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
        UIView *v = [mainWindow viewWithTag:OVERLAY_TAG];
        [UIView animateWithDuration:.3f animations:^{
            v.alpha = 0;
        } completion:^(BOOL finished) {
            [v removeFromSuperview];
        }];
    });
}

- (void)showMalformedYAMLError:(NSError *)error {
    NSString *message = @"Please fill in all text fields with well formed YAML that matches the expected specification.";
    if (error) {
        if (error.domain != YATWSerializationErrorDomain) {
            message = error.localizedDescription;
        } else {
            message = @"There was an error parsing the YAML text you entered. Please try again.";
        }
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
