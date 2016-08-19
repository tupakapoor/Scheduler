//
//  Task.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "Task.h"
#import "Resource.h"

@implementation Task

- (instancetype)initWithName:(NSString *)name coresRequired:(NSNumber *)coresRequired executionTime:(NSNumber *)executionTime parentTasks:(NSArray *)parentTasks {
    self = [super init];
    if (self) {
        _name = name;
        _coresRequired = coresRequired;
        _executionTime = executionTime;
        _parentTasks = parentTasks;
    }
    
    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[Task class]]) {
        Task *cmp = (Task *)object;
        if ([self.name isEqualToString:cmp.name]) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)isFinished {
    return self.remainingExecutionTime.integerValue == 0;
}

- (BOOL)tick {
    NSInteger remainingTime = self.remainingExecutionTime.integerValue;
    remainingTime--;
    self.remainingExecutionTime = @(remainingTime);
    if (remainingTime == 0) {
        return YES;
    }
    
    return NO;
}

@end
