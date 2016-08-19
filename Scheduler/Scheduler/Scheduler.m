//
//  Scheduler.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "Scheduler.h"
#import "Parser.h"
#import "Task.h"
#import "Resource.h"

#import <YAMLThatWorks/YATWSerialization.h>


@interface Scheduler ()

@property (nonatomic, strong) NSMutableArray<Task *> *tasks;
@property (nonatomic, strong) NSDictionary<NSString*,Task*> *tasksByName;
@property (nonatomic, strong) NSArray<Resource *>*resources;

@end

@implementation Scheduler

- (instancetype)initWithTasks:(NSString *)tasks resources:(NSString *)resources  {
    self = [super init];
    if (self) {
        Parser *p = [[Parser alloc] init];
        _tasks = [p parseTasks:tasks];
        NSMutableDictionary *tasksByName = [NSMutableDictionary new];
        for (Task *t in _tasks) {
            tasksByName[t.name] = t;
        }
        _tasksByName = tasksByName;
        
        _resources = [p parseResources:resources];
        
        dispatch_queue_t runLoop = dispatch_queue_create("runLoop", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(runLoop, ^{
            [self runLoop];
        });
    }
    
    return self;
}

- (void)runLoop {
    while (self.tasks.count > 0) {
        for (Resource *r in self.resources) {
            [r tick];
        }
        
        for (NSInteger i = self.tasks.count - 1; i >= 0; i--) {
            Task *t = self.tasks[i];
            for (Resource *r in self.resources) {
                if (r.availableCores >= t.coresRequired.integerValue) {
                    [r addTask:t];
                    [self.tasks removeObjectAtIndex[i]];
                    break;
                }
            }
        }
    }
}


@end
