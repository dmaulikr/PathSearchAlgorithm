//
//  PathGraph.h
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 09/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PathEdge.h"
#import "PathNode.h"
#import "Path.h"

@interface PathGraph : NSObject

@property (nonatomic, strong) NSMutableSet *nodes;

-(void) insertPathFromNode:(NSString *)nodeFrom
                    ToNode:(NSString *)nodeTo
                  WithCost:(CGFloat)cost;

-(void) printGraph;

-(void) printCheapestFirstSearchFromNode : (NSString *)start
                              ToGoalNode : (NSString *)goal;

-(void) explorePathWithFrontier:(NSMutableArray *)frontiers
                UnexploredNodes:(NSMutableSet *) unexploredNodes
                  ExploredNodes:(NSMutableSet *) exploredNodes
                        ForGoal:(PathNode*) goal
                         OnPath:(Path *) currentPath
            WithTotalKnownPaths:(NSMutableArray *) pathList;

// Utilities
- (Path *)fetchCheapestPathFromFrontier : (NSMutableArray *)frontier;
- (PathNode *) pathNodeWithName:(NSString *)nodeName;

@end // Graph
