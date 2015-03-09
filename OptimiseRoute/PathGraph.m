//
//  PathGraph.m
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 09/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import "PathGraph.h"

@implementation PathGraph

-(id) init {
    self = [super init];
    
    if(self) {
        _nodes = [[NSMutableSet alloc] init];
    }
    
    return self;
}

-(void) insertNodeFrom:(PathNode *)from
                ToNode:(PathNode *)targetNode
              WithCost:(NSUInteger)cost {
    
}

-(void) insertNodeFrom:(PathNode *)from
              WithEdge:(PathEdge *)edge {
    
}

-(void) insertPathFromNode:(NSString *)nodeOneName
                    ToNode:(NSString *)nodeTwoName
                  WithCost:(CGFloat)cost {

    __block PathNode *nodeOne = nil;
    __block PathNode *nodeTwo = nil;
    
    // TODO: Explore objectsPassingTest method to find more elegant way of searching
    __block NSUInteger countSet = 0;
    [_nodes enumerateObjectsUsingBlock:^(PathNode *obj, BOOL *stop) {
        if ([obj.name isEqualToString:nodeOneName]) {
            NSLog(@"Item found in existing node: %@", obj.name);
            nodeOne = obj;
        }
        
        if ([obj.name isEqualToString:nodeTwoName]) {
            NSLog(@"Item found in existing node: %@", obj.name);
            nodeTwo = obj;
        }
        
        if((nodeOne != nil && nodeTwo != nil) ||
           countSet == _nodes.count) {
            *stop = YES;
        }
        
        countSet++;
    }];
    
    if(nil == nodeOne) {
        nodeOne = [[PathNode alloc] init];
        nodeOne.name = nodeOneName;
        [_nodes addObject:nodeOne];
    }
    
    if(nil == nodeTwo) {
        nodeTwo = [[PathNode alloc] init];
        nodeTwo.name = nodeTwoName;
        [_nodes addObject:nodeTwo];
    }
    
    // Find if an edge already exists.
    __block PathEdge *nodeEdge = nil;
    for(PathEdge *edge in nodeOne.neighbours) {
        PathNode *neighbourNode = (edge.nodeOne == nodeOne)?edge.nodeTwo:edge.nodeOne;
        if(neighbourNode == nodeTwo) {
            nodeEdge = edge;
        }
    }
    
    // If edge isn't already exist, create one and add the neighbours,
    // otherwise just overwrite the cost.
    if(nodeEdge == nil) {
        nodeEdge = [[PathEdge alloc] init];
        nodeEdge.cost = cost;
        nodeEdge.nodeOne = nodeOne;
        nodeEdge.nodeTwo = nodeTwo;
        [nodeOne addNeighbourwithEdge:nodeEdge];
        [nodeTwo addNeighbourwithEdge:nodeEdge];
    }
    else {
        nodeEdge.cost = cost; // Overwrite the cost
    }
}

-(void) printGraph {
    
    NSMutableSet *exploredList = [NSMutableSet setWithCapacity:_nodes.count];
    for(PathNode *node in _nodes) {
        if(![exploredList containsObject:node]) {
            [exploredList addObject:node];

            for(PathEdge *edge in node.neighbours) {
                PathNode *neighbourNode = (edge.nodeOne == node)?edge.nodeTwo:edge.nodeOne;
                [exploredList addObject:neighbourNode];
            }

            [node printNeighboursWithCost];
        }
    }
}

@end
