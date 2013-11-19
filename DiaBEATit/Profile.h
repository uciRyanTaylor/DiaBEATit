//
//  Profile.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *insulinDependency;
@property (nonatomic, strong) NSString *targetGlucose;
@property (nonatomic, strong) NSString *targetSystolicBP;
@property (nonatomic, strong) NSString *targetDiastolicBP;

-(void) saveProfileLogWithName:(NSString *)name age:(NSString *)age gender:(NSString *)gender height:(NSString *)height weight:(NSString *)weight insulinDependency:(NSString *)insulinDepdency targetGlucose:(NSString *)targetGlucose targetSystolicBP:(NSString *)targetSystolicBP targetDiastolicBP:(NSString *)targetDiastolicDP;

@end
