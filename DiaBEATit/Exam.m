//
//  Exam.m
//  DiaBEATit
//
//  Created by App Jam on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "Exam.h"

@implementation Exam

-(int) editExamWithID:(int)idCode date:(NSString *)date
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
                               @"UPDATE EXAMS SET date = '\"%@\"' WHERE id = %i", date, idCode];
        
        
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

-(NSArray *) retrieveExams
{
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    
    // sql query to get medications
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
                              @"SELECT date FROM exams"];
        
        const char *query_stmt = [querySQL UTF8String];
        int check = sqlite3_prepare_v2(_diaBEATitDB, query_stmt, -1, &statement, NULL);
        //NSLog(@"%i", check);
        if (check == SQLITE_OK)
        {
            //NSLog(@"Entered 2nd if");
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //NSLog(@"Entered while");
                
                NSString *dateField = [[NSString alloc]
                                         initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                [dates addObject:dateField];
                
                NSLog(@"Date: %@", dateField);
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_diaBEATitDB);
    }
    
    return dates;

}

-(IBAction)changeLastCheckupDate:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    lastCheckup.text = dateString;
}

@end
