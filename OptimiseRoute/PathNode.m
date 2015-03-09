//
//  PathNode.m
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 09/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import "PathNode.h"

@implementation PathNode

-(void) addNeighbourwithEdge:(PathEdge *)neighbour {

    __block PathNode *neighbourRef = neighbour.nodeTwo;
    __block PathEdge *edgeRef = nil;
    
    [_neighbours enumerateObjectsUsingBlock:^(PathNode *obj, BOOL *stop) {
        if([obj.name isEqualToString:neighbourRef.name]) {
            neighbourRef = obj;
            edgeRef = neighbour; // Edge already exists. Update the cost
            *stop = YES;
        }
    }];
    
    if(edgeRef == nil) {
        [_neighbours addObject:neighbour];
    }
    else {
        edgeRef.cost = neighbour.cost; // Overwrite existing cost
    }
    
}

-(PathNode *) fetchNeighbourWithName : (NSString *)name {
    __block PathNode *neighbourNode = nil;
    
    [_neighbours enumerateObjectsUsingBlock:^(PathNode *obj, BOOL *stop) {
        if([obj.name isEqualToString:name]) {
            neighbourNode = obj;
            *stop = YES;
        }
    }];
    
    return neighbourNode;
}

-(void) printNeighbours {
    
}

-(void) printNeighboursWithCost {
    for (PathEdge *edge in _neighbours) {
        NSLog(@"%@ %@ %lu", edge.nodeOne, edge.nodeTwo, edge.cost);
    }
}

@end
