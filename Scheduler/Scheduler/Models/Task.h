//
//  Task.h
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Resource;

@interface Task : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *coresRequired;
@property (nonatomic, strong) NSNumber *remainingExecutionTime;
@property (nonatomic, strong) NSNumber *executionTime;
@property (nonatomic, strong) Resource *assignedResource;
@property (nonatomic, strong) NSArray<NSString *> *parentTasks;

- (instancetype)initWithName:(NSString *)name coresRequired:(NSNumber *)coresRequired executionTime:(NSNumber *)executionTime parentTasks:(NSArray *)parentTasks;
- (BOOL)isFinished;
- (BOOL)tick;

@end
