//
// Copyright (c) 2013 InSeven Limited.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "ISXBMC.h"
#import <Unirest/UNIRest.h>
#import <ISUtilities/NSDictionary+JSON.h>

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
