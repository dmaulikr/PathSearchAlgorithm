//
//  PathNode.h
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 09/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PathEdge.h"
#import "Path.h"

@interface PathNode : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableSet *neighbourEdges; // array of edge which stores the target node
@property (nonatomic, strong) Path *exploringPath;

-(void) addNeighbourwithEdge:(PathEdge *)neighbour;

-(PathNode *) fetchNeighbourWithName : (NSString *)name;

-(void) printNeighboursWithCost;

-(NSString *) description;

@end // PathNode
