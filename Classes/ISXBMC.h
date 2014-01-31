//
//  ISXBMC.h
//  Shows
//
//  Created by Jason Barrie Morley on 29/01/2014.
//  Copyright (c) 2014 InSeven Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KSDeferred/KSDeferred.h>

@interface ISXBMC : NSObject


+ (id)xbmc:(NSString *)address;
- (id)init:(NSString *)address;

- (NSArray *)VideoLibrary_GetEpisodes;
- (NSDictionary *)VideoLibrary_GetEpisodeDetails:(NSInteger)episodeid
                                      properties:(NSArray *)properties;
- (NSDictionary *)Files_PrepareDownload:(NSString *)path;

@end
