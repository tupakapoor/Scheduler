//
//  Task.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "Task.h"

@interface Task ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *coresRequired;
@property (nonatomic, strong) NSNumber *executionTime;

@end

@implementation Task

- (instancetype)initWithName:(NSString *)name coresRequired:(NSNumber *)coresRequired executionTime:(NSNumber *)executionTime {
    self = [super init];
    if (self) {
        _name = name;
        _coresRequired = coresRequired;
        _executionTime = executionTime;
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

@end
