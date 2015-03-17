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

@interface PathGraph : NSObject

-(void) insertPathFromNode:(NSString *)nodeFrom
                    ToNode:(NSString *)nodeTo
                  WithCost:(CGFloat)cost;

-(void) printGraph;

-(void) printCheapestFirstSearchFromNode : (NSString *)start
                              ToGoalNode : (NSString *)goal;

-(void) explorePathWithFrontier:(NSMutableArray *) frontiers
                UnexploredNodes:(NSMutableSet *) unexploredNodes
                  ExploredNodes:(NSMutableSet *) exploredNodes
                        ForGoal:(PathNode*) goal
                         OnPath:(NSMutableArray *) currentPathNodes
            WithTotalKnownPaths:(NSMutableArray *) pathList;

-(PathNode *) pathNodeWithName:(NSString *)nodeName;

@property (nonatomic, strong) NSMutableSet *nodes;

@end // Graph
