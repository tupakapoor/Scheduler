//
//  Resource.h
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Task;

@interface Resource : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<Task*> *currentTasks;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *cores;

- (instancetype) initWithName:(NSString *)name cores:(NSNumber *)cores;
- (NSInteger)availableCores;
- (BOOL)addTask:(Task *)task;
- (void)tick;

@end
