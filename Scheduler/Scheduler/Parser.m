//
//  Parser.m
//  Scheduler
//
//  Created by Ameesh Kapoor on 8/16/16.
//  Copyright © 2016 kapoor. All rights reserved.
//

#import "Parser.h"

#import <YAMLThatWorks/YATWSerialization.h>

#define CORES_REQUIRED @"cores_required"
#define EXECUTION_TIME @"execution_time"
#define PARENT_TASKS @"parent_tasks"


@implementation Parser


- (NSMutableArray<Task*> *)parseTasks:(NSString *)tasks {
    NSData *taskData = [tasks dataUsingEncoding:NSUTF8StringEncoding];
    
    id parsedTasks = [self parseYAML:taskData];
    NSLog(@"parsed tasks: %@", parsedTasks);
    if (![parsedTasks isKindOfClass:[NSDictionary class]]) {
        @throw [self errorForUnexpectedFormat];
    }
    
    NSDictionary *tasksDictionary = (NSDictionary *)parsedTasks;
    NSArray<NSString *> *keys = tasksDictionary.allKeys;
    
    NSMutableArray *newTasks = [NSMutableArray new];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    for (NSString *key in keys) {
        NSString *name = key;
        NSDictionary *taskDictionary = tasksDictionary[key];
        if (![taskDictionary isKindOfClass:[NSDictionary class]] || !taskDictionary[CORES_REQUIRED] || !taskDictionary[EXECUTION_TIME]) {
            @throw [self errorForUnexpectedFormat];
        }
        
        NSMutableArray *parentTasks;
        if (taskDictionary[PARENT_TASKS]) {
            if (![taskDictionary[PARENT_TASKS] isKindOfClass:[NSString class]]) {
                @throw [self errorForUnexpectedFormat];
            }
            
            parentTasks = [[taskDictionary[PARENT_TASKS] componentsSeparatedByString:@","] mutableCopy];
            for (int i = 0; i < parentTasks.count; i++) {
                parentTasks[i] = [parentTasks[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
        }
        
        NSNumber *cores = taskDictionary[CORES_REQUIRED];
        NSNumber *executionTime = taskDictionary[EXECUTION_TIME];
        if (!cores || !executionTime) {
            @throw [self errorForUnexpectedFormat];
        }
        
        Task *t = [[Task alloc] initWithName:name
                               coresRequired:cores
                               executionTime:executionTime
                                 parentTasks:parentTasks];
        [newTasks addObject:t];
    }
    
    return newTasks;
}

- (NSArray<Resource*> *)parseResources:(NSString *)tasks {
    NSData *resourceData = [tasks dataUsingEncoding:NSUTF8StringEncoding];
    id parsedResources = [self parseYAML:resourceData];
    NSLog(@"parsed resources: %@", parsedResources);
    if (![parsedResources isKindOfClass:[NSDictionary class]]) {
        @throw [self errorForUnexpectedFormat];
    }
    
    NSDictionary *resourcesDictionary = (NSDictionary *)parsedResources;
    NSArray<NSString *> *keys = resourcesDictionary.allKeys;
    
    NSMutableArray<Resource*> *newResources = [NSMutableArray new];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    for (NSString *key in keys) {
        NSString *name = key;
        NSNumber *cores = resourcesDictionary[key];
        if (!cores) {
            @throw [self errorForUnexpectedFormat];
        }
        
        Resource *r = [[Resource alloc] initWithName:name cores:cores];
        [newResources addObject:r];
    }
    
    return newResources;
}

- (id)parseYAML:(NSData *)yamlData {
    NSError *e;
    id parsedData = [YATWSerialization YAMLObjectWithData:yamlData
                                                  options:0
                                                    error:&e];
    if (e) {
        @throw e;
    }
    
    return parsedData;
}

- (NSError *)errorForUnexpectedFormat {
    return [NSError errorWithDomain:@"AKKParsingErrorDomain"
                               code:400
                           userInfo:@{ NSLocalizedDescriptionKey: @"The input was not in a format matching the spec. Please review and try again." }];
}


@end
