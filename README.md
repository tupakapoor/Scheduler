# Problem

Design a system that, given a set of tasks and available computing resources resources, can complete the described tasks as quickly as possible using parallel execution. The tasks will be described in a YML file and identify necessary resources, duration, and any dependencies on other tasks. The resources will also be described in a YML file indicating how many resources are available per compute core.

# Requirements

## Input

- **YML Files**  
-- Tasks - `cores_required`, `execution_time`, `parent_tasks`  ex: 
```
task1: 
  cores_required: 2 
  execution_time: 100
task2: 
  cores_required: 1 
  execution_time: 200 
  parent_tasks: task1
task3:
  cores_required: 4 
  execution_time: 50 
  parent_tasks: "task1, task2"
```  
-- Resources lists the number of cores available per resource, ex:  
```
compute1: 2 
compute2: 2 
compute3: 6
```

## Output 
- List which resource each task runs on, ex:
```
task1: compute1 
task2: compute1
task3: compute3 
```

# Plan
## Architecture
The system will be an iOS app, written in Objective-C. Because it is an app, there will be an interface with input fields to paste the YAML files in. They'll be parsed and organized and then the scheduling will begin.

My goal is to use a master/worker setup using notifications to indicate when a worker has completed it's task and can be entered back into the pool of available resources. The scheduler (master) will keep track of the pool and query to find the best match for a task and resource.

I am using Cocoapods, a package manager for iOS/OSX applications, to install a YAML reader. 
# Running the app
You will need a computer running OSX with XCode installed in order to run the app. You will also need the ruby gem Cocoapods installed. At the command prompt, cd to the `Scheduler` folder inside the project folder and run  
`pod install`  
This will download any dependencies and create a Scheduler.xcworkspace file. Open this file in XCode, and run the project.

## Task Breakdown

### Input 
__Interface__  
[x] Input fields for yml  
[x] Submit button to start processing  
__Parsing and Validation__  
[x] Text fields not empty  
[x] Valid yml  
[x] Expected format  
[x] Setup data for tasks and resources

__Scheduling__  
[x] Simulate run loop  
[x] Choose available resource for task and assign task to resource  
[ ] Verify parent tasks have completed prior to assignment  
[x] Decrement remaining time per loop  
[ ] Remove completed tasks from resources and Scheduler's list of tasks  
[ ] Note which resource was used for final output
 
# Improvements
Aside from finishing off the programming tasks:
- I did not accomplish the goal as I described above - the system does not use notifications to trigger actions. Instead, a loop is used. This is inefficient and adds a lot of overhead to the scheduler, as the scheduler is now iterating through the resources and tasks, instead of just assigning tasks to a particular resource. This would become incredibly inefficient for large sets of tasks/resources.
- The choice of resource is not intelligent - currently it just chooses the first resource with enough available cores. There are much better ways to do this.
- Test cases. In my haste I did not take the time to write useful test cases. This would increase the dependability of the scheduler.
