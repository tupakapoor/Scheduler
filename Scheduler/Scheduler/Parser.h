//
//  Parser.h
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/16/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Task.h"
#import "Resource.h"

@interface Parser : NSObject

- (NSMutableArray<Task*> *)parseTasks:(NSString *)tasks;
- (NSArray<Resource*> *)parseResources:(NSString *)tasks;

@end
