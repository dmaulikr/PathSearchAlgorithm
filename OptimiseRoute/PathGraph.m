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

-(void) insertPathFromNode:(NSString *)nodeOneName
                    ToNode:(NSString *)nodeTwoName
                  WithCost:(CGFloat)cost {

    __block PathNode *nodeOne = nil;
    __block PathNode *nodeTwo = nil;
    
    // TODO: Explore objectsPassingTest method to find more elegant way of searching
    __block NSUInteger countSet = 0;
    [_nodes enumerateObjectsUsingBlock:^(PathNode *obj, BOOL *stop) {
        if ([obj.name isEqualToString:nodeOneName]) {
            nodeOne = obj;
        }
        
        if ([obj.name isEqualToString:nodeTwoName]) {
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
    for(PathEdge *edge in nodeOne.neighbourEdges) {
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

            for(PathEdge *edge in node.neighbourEdges) {
                PathNode *neighbourNode = (edge.nodeOne == node)?edge.nodeTwo:edge.nodeOne;
                [exploredList addObject:neighbourNode];
            }

            [node printNeighboursWithCost];
        }
    }
}

-(void) printCheapestFirstSearchFromNode : (NSString *)startNodeName
                              ToGoalNode : (NSString *)goalNodeName {
    // Step 1: Get the first state (starting place)
    // Step 2: Get the frontiers
    // Step 3: Remove state node search from frontiers
    // Step 4: Update frontier list based on cheapest step / operational cost
    // Step 5: Update the cheapest path to the main list
    NSMutableSet *unexploredNodes = [_nodes mutableCopy];
    NSMutableSet *exploredNodes = [NSMutableSet setWithCapacity:unexploredNodes.count];
    
    // Array over mutableset as order is important and seek operation isn't.
    NSMutableArray *frontiers = [NSMutableArray arrayWithCapacity:unexploredNodes.count];
    
    // Each object is an array of path nodes leading to.
    NSMutableArray *pathList = [NSMutableArray array];
    NSMutableArray *currentPath = [NSMutableArray array]; // Currently explored path.
    
    PathNode *start = nil;
    PathNode *goal = nil;
    
    for (PathNode *node in unexploredNodes) {
        if([node.name isEqualToString:startNodeName]) {
            start = node;
        }
        if([node.name isEqualToString:goalNodeName]) {
            goal = node;
        }
    }
    
    if(nil == start ||
       nil == goal) {
        return;
    }
    
    // Initial Setup
    [unexploredNodes removeObject:start];
    [exploredNodes addObject:start];
    [frontiers addObject:start];
    
    [self explorePathWithFrontier:frontiers
                  UnexploredNodes:unexploredNodes
                    ExploredNodes:exploredNodes
                          ForGoal:goal
                           OnPath:currentPath
              WithTotalKnownPaths:pathList];
    
    
    for (NSMutableArray *currPath in pathList) {
        for (PathNode *pathNode in currPath) {
            printf("%s ", pathNode.name.UTF8String);
        }
        printf("\r\n");
    }
    
//        NSMutableArray *sortedNeighbour = [NSMutableArray arrayWithCapacity:neighbourEdges.count];
//        NSMutableArray *sortedNeighbourStepCost = [NSMutableArray arrayWithCapacity:neighbourEdges.count];
//        
//        // Get neighbour nodes
//        for(PathEdge *currEdge in neighbourEdges) {
//            PathNode *neighbourStateNode = (currEdge.nodeOne == currentStateNode)?currEdge.nodeTwo:currEdge.nodeOne;
//            [sortedNeighbour addObject:neighbourStateNode];
//            [sortedNeighbourStepCost addObject:sortedNeighbourStepCost];
//        }
        
        // Now that we have all neighbour nodes, lets sort them based on their step cost;

}

-(void) explorePathWithFrontier:(NSMutableArray *) frontiers
                UnexploredNodes:(NSMutableSet *) unexploredNodes
                  ExploredNodes:(NSMutableSet *) exploredNodes
                        ForGoal:(PathNode*) goal
                         OnPath:(NSMutableArray *) currentPathNodes
            WithTotalKnownPaths:(NSMutableArray *) pathList {
    
    if(0 == frontiers.count) {
        return;
    }
    while(frontiers.count > 0) {
        // Remove current node from frontiers;
        PathNode *currentStateNode = frontiers[0];
        [currentPathNodes addObject:currentStateNode];
        [frontiers removeObject:currentStateNode];
        
        [exploredNodes addObject:currentStateNode];
        
        if(goal == currentStateNode) {
            [pathList addObject:currentPathNodes];
            continue;
        }
        
        // Get all the neighbours
        NSMutableArray *neighbourEdges = [NSMutableArray arrayWithArray:currentStateNode.neighbourEdges.allObjects];
        [neighbourEdges sortUsingComparator:^NSComparisonResult(PathEdge *obj1, PathEdge * obj2) {
            return obj1.cost < obj2.cost;
        }];
        
        for(PathEdge *edge in neighbourEdges) {
            PathNode *neighbourNode = (edge.nodeOne == currentStateNode)?edge.nodeTwo : edge.nodeOne;
            if(![exploredNodes containsObject:neighbourNode]) {
                [frontiers addObject:neighbourNode];
            }
        }
    }
//    for(PathNode *currentStateNode in frontiers) {
//        // Remove current node from frontiers;
//        [currentPathNodes addObject:currentStateNode];
//        [frontiers removeObject:currentStateNode];
//        
//        [exploredNodes addObject:currentStateNode];
//        
//        if(goal == currentStateNode) {
//            [pathList addObject:currentPathNodes];
//            break;
//        }
//        
//        // Get all the neighbours
//        NSMutableArray *neighbourEdges = [NSMutableArray arrayWithArray:currentStateNode.neighbourEdges.allObjects];
//        [neighbourEdges sortUsingComparator:^NSComparisonResult(PathEdge *obj1, PathEdge * obj2) {
//            return obj1.cost < obj2.cost;
//        }];
//        
//        for(PathEdge *edge in neighbourEdges) {
//            PathNode *neighbourNode = (edge.nodeOne == currentStateNode)?edge.nodeTwo : edge.nodeOne;
//            [frontiers addObject:neighbourNode];
//        }
//    }
}

-(PathNode *) pathNodeWithName:(NSString *)nodeName {

    PathNode *node = nil;
    for(PathNode *currNode in _nodes) {
        if([currNode.name isEqualToString:nodeName]) {
            node = currNode;
            break;
        }
    }
    
    return node;
}

@end
