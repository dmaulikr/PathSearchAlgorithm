//
//  PathGraph.m
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 09/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import "PathGraph.h"

@implementation PathGraph

-(void) insertNodeFrom:(PathNode *)from
                ToNode:(PathNode *)targetNode
              WithCoSt:(NSUInteger)cost {
    
}

-(void) insertNodeFrom:(PathNode *)from
              WithEdge:(PathEdge *)edge {
    
}

-(void) insertPathFromNode:(NSString *)nodeOneName
                    ToNode:(NSString *)nodeTwoName
                  WithCost:(CGFloat)cost {
    
//    __block PathNode *foundObject = nil;
    __block PathNode *nodeOne = nil;
    __block PathNode *nodeTwo = nil;
    __block NSUInteger countSet = 1;
    
    // TODO: Explore objectsPassingTest method to find more elegant way of searching
    [_nodes enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        NSLog(@"Current item: %@", obj);
        if ([obj isEqualToString:nodeOneName]) {
            nodeOne = obj;
        }

        if ([obj isEqualToString:nodeTwoName]) {
            nodeTwo = obj;
        }
        countSet++;
        
        if((nodeOne != nil && nodeTwo != nil) ||
           countSet == _nodes.count) {
            *stop = YES;
        }
        
    }];

    if(nil == nodeOne) {
        nodeOne = [[PathNode alloc] init];
        nodeOne.name = nodeTwoName;
    }
    if(nil == nodeTwo) {
        nodeTwo = [[PathNode alloc] init];
        nodeTwo.name = nodeTwoName;
    }
    
    PathEdge *edge = [[PathEdge alloc] init];
    edge.cost = cost;
    edge.nodeOne = nodeOne;
    edge.nodeTwo = nodeTwo;
    
    [nodeOne addNeighbourwithEdge:edge];
    [nodeTwo addNeighbourwithEdge:edge];
}

-(void) printGraph {
    
}

@end
