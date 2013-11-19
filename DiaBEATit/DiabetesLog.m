//
//  DiabetesLog.m
//  DiaBEATit
//
//  Created by Kevin Juneja on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "DiabetesLog.h"

@implementation DiabetesLog

-(int) saveDiabetesLogWithGlucose:(NSString *)glucose insulin:(NSString *)insulin a1c:(NSString *)a1c timeOfDay:(NSString *)timeOfDay mealTiming:(NSString *)mealTiming timestamp:(NSString *)timestamp comments:(NSString *)comments
{
    sqlite3_stmt *statement;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath= [pathToDatabase UTF8String];
    int sqlCheck = 1;
    
    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO DIABETESLOGS (glucose, insulin, a1c, timeofday, mealtiming, timestamp, comments) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               glucose, insulin, a1c, timeOfDay, mealTiming, timestamp, comments];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_diaBEATitDB, insert_stmt,
                           -1, &statement, NULL);
        sqlCheck = sqlite3_step(statement);
        if (sqlCheck == SQLITE_DONE)
        {
            NSLog(@"SUCCEEDED");
        } else {
            NSLog(@"FAILED");
            //_status.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_diaBEATitDB);
    }
    
    
    return sqlCheck;
}

-(int) editDiabetesLogWithId:(int)idCode glucose:(NSString *)glucose insulin:(NSString *)insulin a1c:(NSString *)a1c timeOfDay:(NSString *)timeOfDay mealTiming:(NSString *)mealTiming timestamp:(NSString *)timestamp comments:(NSString *)comments
{
    sqlite3_stmt *statement;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath= [pathToDatabase UTF8String];
    int sqlCheck = 1;
    
    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"UPDATE DIABETESLOGS SET glucose = '\"%@\"', insulin = '\"%@\"', a1c = '\"%@\"', timeofday = '\"%@\"', mealtiming = '\"%@\"',  timestamp = '\"%@\"',  comments = '\"%@\"' WHERE id = '\"%i\"'",
                               glucose, insulin, a1c, timeOfDay, mealTiming, timestamp, comments, idCode];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_diaBEATitDB, insert_stmt,
                           -1, &statement, NULL);
        sqlCheck = sqlite3_step(statement);
        if (sqlCheck == SQLITE_DONE)
        {
            NSLog(@"SUCCEEDED");
        } else {
            NSLog(@"FAILED");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_diaBEATitDB);
    }
    
    return sqlCheck;
}

-(int) removeDiabetesLogWithId:(int)idCode
{
    sqlite3_stmt *statement;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath= [pathToDatabase UTF8String];
    int sqlCheck = 1;
    
    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"DELETE FROM DIABETESLOGS WHERE id = '\"%i\"'", idCode];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_diaBEATitDB, insert_stmt,
                           -1, &statement, NULL);
        sqlCheck = sqlite3_step(statement);
        if (sqlCheck == SQLITE_DONE)
        {
            NSLog(@"SUCCEEDED");
        } else {
            NSLog(@"FAILED");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_diaBEATitDB);
    }
    return sqlCheck;
}

-(NSArray *) retrieveDiabetesLogs
    {
    NSMutableArray *diabeteslogs = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToDatabase = [documentsDirectory stringByAppendingPathComponent: @"diaBEATit.db"];
    const char *dbpath = [pathToDatabase UTF8String];
    sqlite3_stmt *statement;
    //NSLog(@"Entered function");
    if (sqlite3_open(dbpath, &_diaBEATitDB) == SQLITE_OK)
    {
        //NSLog(@"Entered 1st if");
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT glucose, insulin, a1c, timeofday, mealtiming, timestamp, comments FROM diabeteslogs"];
        
        const char *query_stmt = [querySQL UTF8String];
        int check = sqlite3_prepare_v2(_diaBEATitDB, query_stmt, -1, &statement, NULL);
        //NSLog(@"%i", check);
        if (check == SQLITE_OK)
        {
            //NSLog(@"Entered 2nd if");
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //NSLog(@"Entered while");
                DiabetesLog *d = [[DiabetesLog alloc] init];
                
                NSString *glucoseField = [[NSString alloc]
                                       initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                d.glucose = glucoseField;
                NSLog(@"Glucose: %@", d.glucose);
                
                NSString *insulinField = [[NSString alloc]
                                         initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                d.insulin = insulinField;
                NSLog(@"Insulin: %@", d.insulin);
                
                NSString *a1cField = [[NSString alloc]
                                           initWithUTF8String:(const char *)
                                           sqlite3_column_text(statement, 2)];
                
                d.a1c = a1cField;
                NSLog(@"A1C: %@", d.a1c);
                
                NSString *timeOfDayField = [[NSString alloc]
                                           initWithUTF8String:(const char *)
                                           sqlite3_column_text(statement, 3)];
                
                d.timeOfDay = timeOfDayField;
                NSLog(@"Time of Day: %@", d.timeOfDay);
                
                NSString *mealTimingField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 4)];
                
                d.mealTiming = mealTimingField;
                NSLog(@"Meal Timing: %@", d.mealTiming);
                
                NSString *timestampField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 5)];
                
                d.timestamp = timestampField;
                NSLog(@"Timestamp: %@", d.timestamp);
                
                NSString *commentsField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 6)];
                
                d.comments = commentsField;
                NSLog(@"Comments: %@", d.comments);
                
                [diabeteslogs addObject:d];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_diaBEATitDB);
    }
    
    //    NSMutableArray *temp = [[NSMutableArray alloc] init];
    //    int tempPtr = 0;
    //    for (int i = [medications count]; i >= 0; i--, tempPtr++) {
    //        [temp addObject:[medications objectAtIndex:i]];
    //    }
    
    return diabeteslogs;
}


@end
