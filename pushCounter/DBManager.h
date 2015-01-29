//
//  DBManager.h
//  pushCounter
//
//  Created by Chiunti on 28/01/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}
+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)saveData:(NSString*)registerNumber detail:(NSString*)detail;
-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;

@end
