//
//  Task.h
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/15/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

- (instancetype)initWithName:(NSString *)name coresRequired:(NSNumber *)coresRequired executionTime:(NSNumber *)executionTime;

@end
