//
//  ISXBMC.m
//  Shows
//
//  Created by Jason Barrie Morley on 29/01/2014.
//  Copyright (c) 2014 InSeven Limited. All rights reserved.
//

#import "ISXBMC.h"
#import <ADURL/ADURL.h>
#import <AFNetworking/AFNetworking.h>
#import <Unirest/UNIRest.h>
#import "NSDictionary+JSON.h"

@interface ISXBMC ()

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSOperationQueue *queue;

@end


@implementation ISXBMC


+ (id)xbmc:(NSString *)address
{
  return [[self alloc] init:address];
}


- (id)init:(NSString *)address
{
  self = [super init];
  if (self) {
    self.address = address;
    self.queue = [NSOperationQueue new];
  }
  return self;
}


- (NSDictionary *)invokeMethod:(NSString *)method
                    parameters:(id)parameters
{
  NSDictionary *params =
  @{@"jsonrpc": @"2.0",
    @"method": method,
    @"params": parameters,
    @"id": @"1"};
  
  NSDictionary* headers = @{@"accept": @"application/json",
                            @"content-type": @"application/json"};
  UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
    [request setUrl:self.address];
    [request setHeaders:headers];
    [request setParameters:@{@"request": [params json]}];
  }] asJson];
  NSDictionary *result = [response.body JSONObject];
//  NSLog(@"Result: %@", result);
  return result[@"result"];
}


- (NSArray *)VideoLibrary_GetEpisodes
{
  NSDictionary *results =
  [self invokeMethod:@"VideoLibrary.GetEpisodes"
          parameters:@[]];
  return results[@"episodes"];
}


- (NSDictionary *)VideoLibrary_GetEpisodeDetails:(NSInteger)episodeid
                                      properties:(NSArray *)properties
{
  NSDictionary *results =
  [self invokeMethod:@"VideoLibrary.GetEpisodeDetails"
          parameters:@[@(episodeid), properties]];
  return results[@"episodedetails"];
}

- (NSDictionary *)Files_PrepareDownload:(NSString *)path
{
  return [self invokeMethod:@"Files.PrepareDownload"
                 parameters:@[path]];
}


@end
