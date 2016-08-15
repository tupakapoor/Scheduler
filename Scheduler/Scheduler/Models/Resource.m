//
//  Resource.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "Resource.h"

@interface Resource ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *cores;

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

@end
