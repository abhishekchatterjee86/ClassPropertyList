//
//  ViewController.m
//  Sample
//
//  Created by Abhishek on 10/03/15.
//  Copyright (c) 2015 Abhishek. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Employee.h"
#import "NSObject+Addition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    NSLog(@"All properties:%@", [Employee propertiesForHierarchyOfClass:[Employee class] onDictionary:[NSMutableDictionary dictionary]]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
