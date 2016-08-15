//
//  Scheduler.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "Scheduler.h"

#import "Task.h"
#import "Resource.h"

#import <YAMLThatWorks/YATWSerialization.h>


@interface Scheduler ()

@property (nonatomic, strong) NSArray<Task *> *tasks;
@property (nonatomic, strong) NSArray<Resource *>*resources;

@end

@implementation Scheduler

- (instancetype)init {
    self = [super init];
    if (self) {
        [self readInputs];
    }
    
    return self;
}

- (void)readInputs {
    NSString *inputsPath = [[NSBundle mainBundle] bundlePath];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:inputsPath];
    NSString *filePath = enumerator.nextObject;
    while (filePath != nil) {
        NSLog(@"filepath: %@", filePath);
        filePath = enumerator.nextObject;
    }
}

@end
