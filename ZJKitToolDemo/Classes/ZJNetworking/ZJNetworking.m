//
//  ZJNetworing.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/7/5.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "ZJNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)

+ (NSString *)zj_Networking_md5:(NSString *)string;

@end

@implementation NSString (md5)

+ (NSString *)zj_Networking_md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

@end

// 网络请求基地址 URL
static NSString *zj_privateNetworkBaseUrl = nil;
// 是否开启打印
static BOOL zj_isEnableInterfaceDebug = NO;
// 是否开启自动编码
static BOOL zj_shouldAutoEncode = YES;
// 请求头
static NSDictionary *zj_httpHeaders = nil;
// 响应类型,默认为 JSON
static ZJResponseType zj_responseType = kZJResponseTypeJSON;
// 请求类型,默认为 PlainText
static ZJRequestType  zj_requestType  = kZJRequestTypePlainText;
// 网络状态
static ZJNetworkStatus zj_networkStatus = kZJNetworkStatusReachableViaWiFi;
// 请求 Tasks
static NSMutableArray *zj_requestTasks;
// Get请求缓存,默认YES开启
static BOOL zj_cacheGet = YES;
// POST请求缓存,默认关闭
static BOOL zj_cachePost = NO;

static BOOL zj_shouldCallbackOnCancelRequest = YES;
// 请求超时时间,默认60秒
static NSTimeInterval zj_timeout = 60.0f;
static BOOL zj_shoulObtainLocalWhenUnconnected = NO;
// 网络请求基地址 baseURL 是否改变
static BOOL zj_isBaseURLChanged = YES;
static AFHTTPSessionManager *zj_sharedManager = nil;
// 最大的缓存大小
static NSUInteger zj_maxCacheSize = 0;
static NSMutableURLRequest *zj_requestMut;
static AFHTTPSessionManager *manager = nil;

#ifdef DEBUG
#define ZJLog(s, ... ) NSLog( @"[%@ in line %d] ===============> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define ZJLog(s, ... )
#endif
@interface ZJNetworking ()

@end

@implementation ZJNetworking

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 尝试清除缓存
        if (zj_maxCacheSize > 0 && [self totalCacheSize] > 1024 * 1024 * zj_maxCacheSize) {
            [self clearCaches];
        }
    });
}

// 配置网络请求基地址
+(NSString *)baseURL{
    return zj_privateNetworkBaseUrl;
}

// 是否是调试模式
+ (BOOL)isDebug {
    return zj_isEnableInterfaceDebug;
}
// 更新网络请求基地址
+ (void)updateBaseURL:(NSString *)baseURLString{
    if (![baseURLString isEqualToString:zj_privateNetworkBaseUrl] && baseURLString && baseURLString.length) {
        zj_isBaseURLChanged = YES;
    } else {
        zj_isBaseURLChanged = NO;
    }
    
    zj_privateNetworkBaseUrl = baseURLString;
}
// 设置请求超时是时间
+ (void)setTimeout:(NSTimeInterval)timeout {
    zj_timeout = timeout;
}
// 默认不会自动清除缓存，如果需要，可以设置自动清除缓存，并且需要指定上限。当指定上限>0M时，若缓存达到了上限值，则每次启动应用则尝试自动去清理缓存。
+ (void)autoToClearCacheWithLimitedToSize:(NSUInteger)mSize {
    zj_maxCacheSize = mSize;
}
// 打开或者关闭打印
+ (void)enableInterfaceDebug:(BOOL)isDebug {
    zj_isEnableInterfaceDebug = isDebug;
}
+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost {
    zj_cacheGet = isCacheGet;
    zj_cachePost = shouldCachePost;
}

// 配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
+ (void)configRequestType:(ZJRequestType)requestType
             responseType:(ZJResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest {
    zj_requestType = requestType;
    zj_responseType = responseType;
    zj_shouldAutoEncode = shouldAutoEncode;
    zj_shouldCallbackOnCancelRequest = shouldCallbackOnCancelRequest;
}

//配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders {
    zj_httpHeaders = httpHeaders;
}
// 当检查到网络异常时，是否从从本地提取数据。默认为NO。一旦设置为YES,当设置刷新缓存时，若网络异常也会从缓存中读取数据。同样，如果设置超时不回调，同样也会在网络异常时回调，除非 本地没有数据！
+ (void)obtainDataFromLocalWhenNetworkUnconnected:(BOOL)shouldObtain {
    zj_shoulObtainLocalWhenUnconnected = shouldObtain;
    if (zj_shoulObtainLocalWhenUnconnected && (zj_cacheGet || zj_cachePost)) {
        [self detectNetwork];
    }
}
// 是否需要 UTF-8 编码
+ (BOOL)shouldEncode {
    return zj_shouldAutoEncode;
}


// 不带参数
+ (ZJURLSessionTask *)getWithURLString:(NSString *)URLString
                          refreshCache:(BOOL)refreshCache
                               success:(ZJResponseSuccess)success
                                  fail:(ZJResponseFail)fail{
    return [self requestWithURLString:URLString
                         refreshCache:refreshCache
                            httpMedth:1
                               params:nil
                             progress:nil
                              success:success
                                 fail:fail];
}
// params参数
+ (ZJURLSessionTask *)getWithURLString:(NSString *)URLString
                          refreshCache:(BOOL)refreshCache
                                params:(id)params
                               success:(ZJResponseSuccess)success
                                  fail:(ZJResponseFail)fail{
    return [self requestWithURLString:URLString
                         refreshCache:refreshCache
                            httpMedth:1
                               params:params
                             progress:nil
                              success:success
                                 fail:fail];
}
//带进度回调
+ (ZJURLSessionTask *)getWithURLString:(NSString *)URLString
                          refreshCache:(BOOL)refreshCache
                                params:(id)params
                              progress:(ZJGetProgress)progress
                               success:(ZJResponseSuccess)success
                                  fail:(ZJResponseFail)fail{
    return [self requestWithURLString:URLString
                         refreshCache:refreshCache
                            httpMedth:1 params:params
                             progress:progress
                              success:success
                                 fail:fail];
}

// 带参数
+ (ZJURLSessionTask *)postWithURLString:(NSString *)URLString
                           refreshCache:(BOOL)refreshCache
                                 params:(id)params
                                success:(ZJResponseSuccess)success
                                   fail:(ZJResponseFail)fail{
    return [self requestWithURLString:URLString
                         refreshCache:refreshCache
                            httpMedth:2
                               params:params
                             progress:nil
                              success:success
                                 fail:fail];
}

// 带参数
+ (ZJURLSessionTask *)postWithURLString:(NSString *)URLString
                           refreshCache:(BOOL)refreshCache
                                 params:(id)params
                               progress:(ZJPostProgress)progress
                                success:(ZJResponseSuccess)success
                                   fail:(ZJResponseFail)fail{
    return [self requestWithURLString:URLString
                         refreshCache:refreshCache
                            httpMedth:2 params:params
                             progress:progress
                              success:success
                                 fail:fail];
}

#pragma mark - 网络请求的实现
+ (ZJURLSessionTask *)requestWithURLString:(NSString *)URLString
                              refreshCache:(BOOL)refreshCache
                                 httpMedth:(NSUInteger)httpMethod
                                    params:(NSDictionary *)params
                                  progress:(ZJDownloadProgress)progress
                                   success:(ZJResponseSuccess)success
                                      fail:(ZJResponseFail)fail {
    if ([self shouldEncode]) {
        URLString = [self encodeUrl:URLString];
    }
    
    AFHTTPSessionManager *manager = [self manager];
    NSString *absolute = [self absoluteUrlWithPath:URLString];
    
    if ([self baseURL] == nil) {
        if ([NSURL URLWithString:URLString] == nil) {
            ZJLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        NSURL *absoluteURL = [NSURL URLWithString:absolute];
        
        if (absoluteURL == nil) {
            ZJLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    ZJURLSessionTask *session = nil;
    
    if (httpMethod == 1) {
        if (zj_cacheGet) {
            if (zj_shoulObtainLocalWhenUnconnected) {
                if (zj_networkStatus == kZJNetworkStatusNotReachable ||  zj_networkStatus == kZJNetworkStatusUnknown ) {
                    id response = [ZJNetworking cahceResponseWithURL:absolute
                                                          parameters:params];
                    if (response) {
                        if (success) {
                            [self successResponse:response callback:success];
                            
                            if ([self isDebug]) {
                                [self logWithSuccessResponse:response
                                                         url:absolute
                                                      params:params];
                            }
                        }
                        return nil;
                    }
                }
            }
            if (!refreshCache) {// 获取缓存
                id response = [ZJNetworking cahceResponseWithURL:absolute
                                                      parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                    return nil;
                }
            }
        }
        
        session = [manager GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            
            if (zj_cacheGet) {
                [self cacheResponseObject:responseObject request:task.currentRequest parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self allTasks] removeObject:task];
            
            if ([error code] < 0 && zj_cacheGet) {// 获取缓存
                id response = [ZJNetworking cahceResponseWithURL:absolute
                                                      parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                } else {
                    [self handleCallbackWithError:error fail:fail];
                    
                    if ([self isDebug]) {
                        [self logWithFailError:error url:absolute params:params];
                    }
                }
            } else {
                [self handleCallbackWithError:error fail:fail];
                
                if ([self isDebug]) {
                    [self logWithFailError:error url:absolute params:params];
                }
            }
        }];
    } else if (httpMethod == 2) {
        if (zj_cachePost ) {// 获取缓存
            if (zj_shoulObtainLocalWhenUnconnected) {
                if (zj_networkStatus == kZJNetworkStatusNotReachable ||  zj_networkStatus == kZJNetworkStatusUnknown ) {
                    id response = [ZJNetworking cahceResponseWithURL:absolute
                                                          parameters:params];
                    if (response) {
                        if (success) {
                            [self successResponse:response callback:success];
                            
                            if ([self isDebug]) {
                                [self logWithSuccessResponse:response
                                                         url:absolute
                                                      params:params];
                            }
                        }
                        return nil;
                    }
                }
            }
            if (!refreshCache) {
                id response = [ZJNetworking cahceResponseWithURL:absolute
                                                      parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                    return nil;
                }
            }
        }
        
        session = [manager POST:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successResponse:responseObject callback:success];
            
            if (zj_cachePost) {
                [self cacheResponseObject:responseObject request:task.currentRequest  parameters:params];
            }
            
            [[self allTasks] removeObject:task];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:absolute
                                      params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self allTasks] removeObject:task];
            
            if ([error code] < 0 && zj_cachePost) {// 获取缓存
                id response = [ZJNetworking cahceResponseWithURL:absolute
                                                      parameters:params];
                
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                } else {
                    [self handleCallbackWithError:error fail:fail];
                    
                    if ([self isDebug]) {
                        [self logWithFailError:error url:absolute params:params];
                    }
                }
            } else {
                [self handleCallbackWithError:error fail:fail];
                
                if ([self isDebug]) {
                    [self logWithFailError:error url:absolute params:params];
                }
            }
        }];
    }
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (ZJURLSessionTask *)uploadFileWithURLString:(NSString *)URLString
                                uploadingFile:(NSString *)uploadingFile
                                     progress:(ZJUploadProgress)progress
                                      success:(ZJResponseSuccess)success
                                         fail:(ZJResponseFail)fail {
    if ([NSURL URLWithString:uploadingFile] == nil) {
        ZJLog(@"uploadingFile无效，无法生成URL。请检查待上传文件是否存在");
        return nil;
    }
    
    NSURL *uploadURL = nil;
    if ([self baseURL] == nil) {
        uploadURL = [NSURL URLWithString:URLString];
    } else {
        uploadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], URLString]];
    }
    
    if (uploadURL == nil) {
        ZJLog(@"URLString无效，无法生成URL。可能是URL中有中文或特殊字符，请尝试Encode URL");
        return nil;
    }
    
    AFHTTPSessionManager *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    ZJURLSessionTask *session = nil;
    
    [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        [self successResponse:responseObject callback:success];
        
        if (error) {
            [self handleCallbackWithError:error fail:fail];
            
            if ([self isDebug]) {
                [self logWithFailError:error url:response.URL.absoluteString params:nil];
            }
        } else {
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:response.URL.absoluteString
                                      params:nil];
            }
        }
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}
+ (ZJURLSessionTask *)uploadWithImage:(UIImage *)image
                            URLString:(NSString *)URLString
                             filename:(NSString *)filename
                                 name:(NSString *)name
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary *)parameters
                             progress:(ZJUploadProgress)progress
                              success:(ZJResponseSuccess)success
                                 fail:(ZJResponseFail)fail {
    if ([self baseURL] == nil) {
        if ([NSURL URLWithString:URLString] == nil) {
            ZJLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], URLString]] == nil) {
            ZJLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    if ([self shouldEncode]) {
        URLString = [self encodeUrl:URLString];
    }
    
    NSString *absolute = [self absoluteUrlWithPath:URLString];
    
    AFHTTPSessionManager *manager = [self manager];
    ZJURLSessionTask *session = [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allTasks] removeObject:task];
        [self successResponse:responseObject callback:success];
        
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject
                                     url:absolute
                                  params:parameters];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allTasks] removeObject:task];
        
        [self handleCallbackWithError:error fail:fail];
        
        if ([self isDebug]) {
            [self logWithFailError:error url:absolute params:nil];
        }
    }];
    
    [session resume];
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (ZJURLSessionTask *)downloadWithURLString:(NSString *)URLString
                                 saveToPath:(NSString *)saveToPath
                                   progress:(ZJDownloadProgress)progressBlock
                                    success:(ZJResponseSuccess)success
                                    failure:(ZJResponseFail)failure {
    if ([self baseURL] == nil) {
        if ([NSURL URLWithString:URLString] == nil) {
            ZJLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], URLString]] == nil) {
            ZJLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    AFHTTPSessionManager *manager = [self manager];
    
    ZJURLSessionTask *session = nil;
    
    session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        if (error == nil) {
            if (success) {
                success(filePath.absoluteString);
            }
            
            if ([self isDebug]) {
                ZJLog(@"Download success for url %@",
                      [self absoluteUrlWithPath:URLString]);
            }
        } else {
            [self handleCallbackWithError:error fail:failure];
            
            if ([self isDebug]) {
                ZJLog(@"Download fail for url %@, reason : %@",
                      [self absoluteUrlWithPath:URLString],
                      [error description]);
            }
        }
    }];
    
    [session resume];
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}


// 成功回调
+ (void)successResponse:(id)responseData callback:(ZJResponseSuccess)success {
    if (success) {
        success([self tryToParseData:responseData]);
    }
}

// 失败回调
+ (void)handleCallbackWithError:(NSError *)error fail:(ZJResponseFail)fail {
    if ([error code] == NSURLErrorCancelled) {
        if (zj_shouldCallbackOnCancelRequest) {
            if (fail) {
                fail(error);
            }
        }
    } else {
        if (fail) {
            fail(error);
        }
    }
}



// 解析响应数据
+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (url == nil) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(ZJURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[ZJURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

+ (id)cahceResponseWithURL:(NSString *)url parameters:params {
    id cacheData = nil;
    
    if (url) {
        // Try to get datas from disk
        NSString *directoryPath = cachePath();
        NSString *absoluteURL = [self generateGETAbsoluteURL:url params:params];
        NSString *key = [NSString zj_Networking_md5:absoluteURL];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        if (data) {
            cacheData = data;
            ZJLog(@"Read data from cache for url: %@\n", url);
        }
    }
    
    return cacheData;
}

+ (void)cacheResponseObject:(id)responseObject request:(NSURLRequest *)request parameters:params {
    if (request && responseObject && ![responseObject isKindOfClass:[NSNull class]]) {
        NSString *directoryPath = cachePath();
        
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            if (error) {
                ZJLog(@"create cache dir error: %@\n", error);
                return;
            }
        }
        
        NSString *absoluteURL = [self generateGETAbsoluteURL:request.URL.absoluteString params:params];
        NSString *key = [NSString zj_Networking_md5:absoluteURL];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSData *data = nil;
        if ([dict isKindOfClass:[NSData class]]) {
            data = responseObject;
        } else {
            data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        }
        
        if (data && error == nil) {
            BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
            if (isOk) {
                ZJLog(@"cache file ok for request: %@\n", absoluteURL);
            } else {
                ZJLog(@"cache file error for request: %@\n", absoluteURL);
            }
        }
    }
}
+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    ZJLog(@"\n");
    ZJLog(@"\nRequest success 🍏, URL: %@\n params:%@\n response:%@\n\n",
          [self generateGETAbsoluteURL:url params:params],
          params,
          [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params {
    NSString *format = @" params: ";
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        format = @"";
        params = @"";
    }
    
    ZJLog(@"\n");
    if ([error code] == NSURLErrorCancelled) {
        ZJLog(@"\nRequest was canceled mannully, URL: %@ %@%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              format,
              params);
    } else {
        ZJLog(@"\nRequest error 🍎, URL: %@ %@%@\n errorInfos:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              format,
              params,
              [error localizedDescription]);
    }
}

#pragma mark - Private
+ (AFHTTPSessionManager *)manager {
    @synchronized (self) {
        // 只要不切换baseurl，就一直使用同一个session manager
        if (zj_sharedManager == nil || zj_isBaseURLChanged) {
            // 开启转圈圈
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                if ([self baseURL] != nil) {
                    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseURL]]];
                } else {
                    manager = [AFHTTPSessionManager manager];
                }
            });
            
            switch (zj_requestType) {
                case kZJRequestTypeJSON: {
                    manager.requestSerializer = [AFJSONRequestSerializer serializer];
                    break;
                }
                case kZJRequestTypePlainText: {
                    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                    break;
                }
                default: {
                    break;
                }
            }
            
            switch (zj_responseType) {
                case kZJResponseTypeJSON: {
                    manager.responseSerializer = [AFJSONResponseSerializer serializer];
                    break;
                }
                case kZJResponseTypeXML: {
                    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
                    break;
                }
                case kZJResponseTypeData: {
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    break;
                }
                default: {
                    break;
                }
            }
            
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            
            
            for (NSString *key in zj_httpHeaders.allKeys) {
                if (zj_httpHeaders[key] != nil) {
                    [manager.requestSerializer setValue:zj_httpHeaders[key] forHTTPHeaderField:key];
                }
            }
            
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                      @"text/html",
                                                                                      @"text/json",
                                                                                      @"text/plain",
                                                                                      @"text/javascript",
                                                                                      @"text/xml",
                                                                                      @"image/*"]];
            
            manager.requestSerializer.timeoutInterval = zj_timeout;
            
            // 设置允许同时最大并发数量，过大容易出问题
            manager.operationQueue.maxConcurrentOperationCount = 3;
            zj_sharedManager = manager;
        }
    }
    
    return zj_sharedManager;
}


// 配置 URL
+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    
    if ([self baseURL] == nil || [[self baseURL] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        if ([[self baseURL] hasSuffix:@"/"]) {
            if ([path hasPrefix:@"/"]) {
                NSMutableString * mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",
                               [self baseURL], mutablePath];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseURL], path];
            }
        } else {
            if ([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseURL], path];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
                               [self baseURL], path];
            }
        }
    }
    
    return absoluteUrl;
}

// 取消所有请求
+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(ZJURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[ZJURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
    
}


+ (void)clearCaches {
    NSString *directoryPath = cachePath();
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
        
        if (error) {
            NSLog(@"ZJNetworking clear caches error: %@", error);
        } else {
            NSLog(@"ZJNetworking clear caches ok");
        }
    }
}


+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (zj_requestTasks == nil) {
            zj_requestTasks = [[NSMutableArray alloc] init];
        }
    });
    
    return zj_requestTasks;
}
// 获取全部的缓存
+ (unsigned long long)totalCacheSize {
    NSString *directoryPath = cachePath();
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}

// 定义一个缓存地址
static inline NSString *cachePath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ZJNetworkingCaches"];
}


+ (void)detectNetwork {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable){
            zj_networkStatus = kZJNetworkStatusNotReachable;
        } else if (status == AFNetworkReachabilityStatusUnknown){
            zj_networkStatus = kZJNetworkStatusUnknown;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            zj_networkStatus = kZJNetworkStatusReachableViaWWAN;
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            zj_networkStatus = kZJNetworkStatusReachableViaWiFi;
        }
    }];
}

// 仅对一级字典结构起作用 //   || [params count] == 0
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}


+ (NSString *)encodeUrl:(NSString *)url {
    return [self zj_URLEncode:url];
}

// URL UTF-8编码  防止含有中文错误
+ (NSString *)zj_URLEncode:(NSString *)url {
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}


/*******************  网络监测  *************************/

NSString * const ZJNotificationNetworkStatusUnknown         = @"ZJNotificationNetworkStatusUnknown";       //未知网络
NSString * const ZJNotificationNetworkStatusNotReachable    = @"ZJNotificationNetworkStatusNotReachable";  //无网络
NSString * const ZJNotificationNetworkStatusViaWWAN         = @"ZJNotificationNetworkStatusViaWWAN";       //蜂窝网络
NSString * const ZJNotificationNetworkStatusViaWiFi         = @"ZJNotificationNetworkStatusViaWiFi";       //WIFI


#pragma mark - 开始监听网络
+ (void)startNetworkStatusWithBlock:(void(^)(ZJNetworkStatus status))networkStatus{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status){
                case AFNetworkReachabilityStatusUnknown:{
                    networkStatus ? networkStatus(kZJNetworkStatusUnknown) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:ZJNotificationNetworkStatusUnknown object:nil];
                    ZJLog(@"未知网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:{
                    networkStatus ? networkStatus(kZJNetworkStatusNotReachable) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:ZJNotificationNetworkStatusNotReachable object:nil];
                    ZJLog(@"无网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    networkStatus ? networkStatus(kZJNetworkStatusReachableViaWWAN) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:ZJNotificationNetworkStatusViaWWAN object:nil];
                    ZJLog(@"蜂窝网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    networkStatus ? networkStatus(kZJNetworkStatusReachableViaWiFi) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:ZJNotificationNetworkStatusViaWiFi object:nil];
                    ZJLog(@"WIFI 网络");
                }
                    break;
            }
        }];
        
        [reachabilityManager startMonitoring];
    });
}
#pragma mark - 是否有网
+ (BOOL)isReachable{
    
    return [AFNetworkReachabilityManager sharedManager].reachable;
    
}
#pragma mark - 是否是蜂窝网络
+ (BOOL)isWWANNetwork{
    
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
    
}
#pragma mark - 是否是WIFI
+ (BOOL)isWiFiNetwork{
    
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
    
}

@end








