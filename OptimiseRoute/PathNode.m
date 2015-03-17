//
//  PathNode.m
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 09/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import "PathNode.h"

@implementation PathNode

-(id) init {
    self = [super init];
    
    if(self) {
        _neighbourEdges = [[NSMutableSet alloc] init];
    }
    
    return self;
}

-(void) addNeighbourwithEdge:(PathEdge *)neighbour {
    if(![_neighbourEdges containsObject:neighbour]) {
        [_neighbourEdges addObject:neighbour];
    }
}

-(PathNode *) fetchNeighbourWithName : (NSString *)name {
    __block PathNode *neighbourNode = nil;
    
    [_neighbourEdges enumerateObjectsUsingBlock:^(PathNode *obj, BOOL *stop) {
        if([obj.name isEqualToString:name]) {
            neighbourNode = obj;
            *stop = YES;
        }
    }];
    
    return neighbourNode;
}

-(void) printNeighboursWithCost {
    for (PathEdge *edge in _neighbourEdges) {
        NSLog(@"%@ %@ %F", edge.nodeOne.name , edge.nodeTwo.name, edge.cost);
    }
}

@end
