//
//  PathEdge.h
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 09/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PathNode;

@interface PathEdge : NSObject
    @property (assign) CGFloat cost;
    @property (nonatomic, weak) PathNode *nodeOne;
    @property (nonatomic, weak) PathNode *nodeTwo;
-(void) printEdge;

@end // PathEdge
