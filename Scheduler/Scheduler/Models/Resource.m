//
//  Resource.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "Resource.h"
#import "Task.h"

@interface Resource ()

@property (nonatomic, strong) NSMutableArray<Task*> *currentTasks;

@end


@implementation Resource

- (instancetype) initWithName:(NSString *)name cores:(NSNumber *)cores {
    self = [super init];
    if (self) {
        _name = name;
        _cores = cores;
    }
    
    return self;
}

- (NSInteger)availableCores {
    NSInteger coresInUse = 0;
    for (Task *t in self.currentTasks) {
        coresInUse += t.coresRequired.integerValue;
    }
    
    return self.cores.integerValue - coresInUse;
}

- (BOOL)addTask:(Task *)task {
    if (self.availableCores >= task.coresRequired.integerValue) {
        [self.currentTasks addObject:task];
        return YES;
    }
    
    return NO;
}

- (void)tick {
    for (NSInteger i = self.currentTasks.count - 1; i >= 0; i--) {
        Task *t = self.currentTasks[i];
        if ([t tick]) {
            [self.currentTasks removeObjectAtIndex:i];
        }
    }
}

@end
