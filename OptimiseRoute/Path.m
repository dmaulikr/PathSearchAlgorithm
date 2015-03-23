//
//  Path.m
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 17/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import "Path.h"

@implementation Path


-(id) init {
    self = [super init];
    
    if (self) {
        _nodes = [NSMutableArray array];
        _pathCost = 0;
        _stepCost = 0;
    }
    
    return self;
}

//-(NSString *) description {
//    NSString *pathDescription = [NSString stringWithFormat:@"%@ %lf", _nodes.description, _pathCost];
//    return pathDescription;
//}

@end
