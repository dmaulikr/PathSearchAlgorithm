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

-(void) insertNodeFrom:(PathNode *)from
                ToNode:(PathNode *)targetNode
              WithCoSt:(NSUInteger)cost;

-(void) insertNodeFrom:(PathNode *)from
              WithEdge:(PathEdge *)edge;

-(void) insertPathFromNode:(NSString *)nodeFrom
                    ToNode:(NSString *)nodeTo
                  WithCost:(CGFloat)cost;

-(void) printGraph;

@property (nonatomic, strong) NSMutableSet *nodes;

@end // Graph
