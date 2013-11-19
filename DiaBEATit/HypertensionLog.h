//
//  HypertensionLog.h
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Log.h"

@interface HypertensionLog : NSObject

@property (nonatomic, strong) NSString *systolic;
@property (nonatomic, strong) NSString *diastolic;
@property (nonatomic, strong) NSString *heartRate;
@property (nonatomic, strong) NSString *timeOfDay;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *comments;

@property (nonatomic) sqlite3 *diaBEATitDB;

-(int) saveHypertensionLogWithSystolicBP:(NSString *)systolic diastolicBP:(NSString *)diastolic heartRate:(NSString *)heartRate timeOfDay:(NSString *)timeOfDay timestamp:(NSString *)timestamp comments:(NSString *)comments;

-(NSArray *) retrieveHypertensionLogs;

@end
