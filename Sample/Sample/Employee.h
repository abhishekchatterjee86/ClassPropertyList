//
//  Employee.h
//  Sample
//
//  Created by Abhishek on 10/03/15.
//  Copyright (c) 2015 Abhishek. All rights reserved.
//

#import "Person.h"

@interface Employee : Person

@property (nonatomic , strong) NSString *companyName;
@property (nonatomic , strong) NSString *salary;

@end
