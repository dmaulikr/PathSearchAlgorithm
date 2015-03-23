//
//  Path.h
//  OptimiseRoute
//
//  Created by Vaibhav Panchal on 17/03/2015.
//  Copyright (c) 2015 VaibhavPanchal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Path : NSObject
@property (nonatomic, strong) NSMutableArray *nodes;
@property (nonatomic, assign) CGFloat pathCost;
@property (nonatomic, assign) CGFloat stepCost;

//-(NSString *) description;

@end
