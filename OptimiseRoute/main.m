//
//  main.m
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 09/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PathGraph.h"

#import <string.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        NSUInteger numberOfK;
        scanf("%lu", &numberOfK);
        PathGraph *graph = [[PathGraph alloc] init];
        
        for(int i = 0; i < numberOfK; i++) {
            CGFloat cost;
            char cityOneName[10000];
            char cityTwoName[10000];
            scanf("%s %s %lf", cityOneName, cityTwoName, &cost);
            NSString *cityOne = [NSString stringWithCString:cityOneName
                                                    encoding:NSUTF8StringEncoding];
            
            NSString *cityTwo = [NSString stringWithCString:cityTwoName
                                                   encoding:NSUTF8StringEncoding];

//            NSString *cityOne = [NSString stringWithFormat:@"%d",cityOneCodeName];
//            NSString *cityTwo = [NSString stringWithFormat:@"%d",cityTwoCodeName];
//            NSLog(@"City Names %@ %@",cityOne, cityTwo);
            
            // Converting int to string for easy printing as no integer arthemetic needs to be done on city indentities.
            [graph insertPathFromNode:cityOne
                               ToNode:cityTwo
                             WithCost:cost];
            
        }
        
        [graph printGraph];
        
        [graph printCheapestFirstSearchFromNode:@"A"
                                     ToGoalNode:@"H"];
        
        
    }
    return 0;
}
