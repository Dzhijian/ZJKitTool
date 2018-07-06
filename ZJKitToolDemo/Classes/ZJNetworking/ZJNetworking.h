//
//  ZJNetworing.h
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/7/5.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 下载进度 Block
 
 @param bytesRead 已下载大小
 @param totalBytesRead 总下载大小
 */
typedef void (^ZJDownloadProgress)(int64_t bytesRead, int64_t totalBytesRead);

/**
 上传进度 Block
 
 @param bytesWritten  已上传大小
 @param totalBytesWritten 总上传大小
 */
typedef void (^ZJUploadProgress)(int64_t bytesWritten, int64_t totalBytesWritten);

typedef ZJDownloadProgress ZJGetProgress;
typedef ZJDownloadProgress ZJPostProgress;

/**
 响应数据返回类型
 */
typedef NS_ENUM(NSUInteger, ZJResponseType) {
    kZJResponseTypeJSON = 1, // 默认
    kZJResponseTypeXML  = 2, // XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    kZJResponseTypeData = 3
};
/**
 请求参数类型
 */
typedef NS_ENUM(NSUInteger, ZJRequestType) {
    kZJRequestTypeJSON = 1, // 默认
    kZJRequestTypePlainText  = 2 // 普通text/html
};
/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, ZJNetworkStatus) {
    kZJNetworkStatusUnknown          = -1,//未知网络
    kZJNetworkStatusNotReachable     = 0,//网络无连接
    kZJNetworkStatusReachableViaWWAN = 1,//2，3，4G网络
    kZJNetworkStatusReachableViaWiFi = 2,//WIFI网络
};

typedef NSURLSessionTask ZJURLSessionTask;

/**
 请求成功回调
 
 @param response 响应数据
 */
typedef void(^ZJResponseSuccess)(id response);

/**
 请求失败回调
 
 @param error 错误信息
 */
typedef void(^ZJResponseFail)(NSError *error);

@interface ZJNetworking : NSObject

/**
 *  网络请求基础地址 URL
 */
+ (NSString *)baseURL;

/**
 指定网络请求接口的基础 URL
 
 @param baseURLString 网络接口的基础 URL
 */
+ (void)updateBaseURL:(NSString *)baseURLString;

/**
 设置请求超时时间,默认为60秒
 
 @param timeout 超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout;

/**
 当检查到网络异常时，是否从从本地提取数据。默认为NO。一旦设置为YES,当设置刷新缓存时，
 若网络异常也会从缓存中读取数据。同样，如果设置超时不回调，同样也会在网络异常时回调，除非
 本地没有数据！
 
 @param shouldObtain    YES/NO
 */
+ (void)obtainDataFromLocalWhenNetworkUnconnected:(BOOL)shouldObtain;

/**
 获取缓存总大小/bytes
 
 @return 缓存大小
 */
+ (unsigned long long)totalCacheSize;


/**
 默认不会自动清除缓存，如果需要，可以设置自动清除缓存，并且需要指定上限。当指定上限>0M时，若缓存达到了上限值，则每次启动应用则尝试自动去清理缓存。
 
 @param mSize 缓存上限大小，单位为M（兆），默认为0，表示不清理
 */
+ (void)autoToClearCacheWithLimitedToSize:(NSUInteger)mSize;

/**
 清理缓存
 */
+ (void)clearCaches;

/**
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开，默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *
 *  @param requestType 请求格式，默认为JSON
 *  @param responseType 响应格式，默认为JSO，
 *  @param shouldAutoEncode YES or NO,默认为NO，是否自动encode url
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)configRequestType:(ZJRequestType)requestType
             responseType:(ZJResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest;

/**
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *
 *    取消所有请求
 */
+ (void)cancelAllRequest;

/**
 *
 *    取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的ZJURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *
 *    @param url                URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
+ (void)cancelRequestWithURL:(NSString *)url;


/**
 GET请求接口，若不指定baseurl，可传完整的url
 
 @param URLString     接口路径，如/path/getArticleList
 @param refreshCache  是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 params  接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 @param success 接口成功请求到数据的回调
 @param fail    接口请求数据失败的回调
 
 @return 返回的对象中有可取消请求的API
 */
+ (ZJURLSessionTask *)getWithURLString:(NSString *)URLString
                          refreshCache:(BOOL)refreshCache
                               success:(ZJResponseSuccess)success
                                  fail:(ZJResponseFail)fail;
// 多一个params参数
+ (ZJURLSessionTask *)getWithURLString:(NSString *)URLString
                          refreshCache:(BOOL)refreshCache
                                params:(id)params
                               success:(ZJResponseSuccess)success
                                  fail:(ZJResponseFail)fail;
// 多一个带进度回调
+ (ZJURLSessionTask *)getWithURLString:(NSString *)URLString
                          refreshCache:(BOOL)refreshCache
                                params:(id)params
                              progress:(ZJGetProgress)progress
                               success:(ZJResponseSuccess)success
                                  fail:(ZJResponseFail)fail;

/*!
 
 POST请求接口，若不指定baseurl，可传完整的url
 
 @param URLString     接口路径，如/path/getArticleList
 @param params  接口中所需的参数，如@{"categoryid" : @(12)}
 @param success 接口成功请求到数据的回调
 @param fail    接口请求数据失败的回调
 
 @return 返回的对象中有可取消请求的API
 */
+ (ZJURLSessionTask *)postWithURLString:(NSString *)URLString
                           refreshCache:(BOOL)refreshCache
                                 params:(id)params
                                success:(ZJResponseSuccess)success
                                   fail:(ZJResponseFail)fail;
+ (ZJURLSessionTask *)postWithURLString:(NSString *)URLString
                           refreshCache:(BOOL)refreshCache
                                 params:(id)params
                               progress:(ZJPostProgress)progress
                                success:(ZJResponseSuccess)success
                                   fail:(ZJResponseFail)fail;

/**
 
 图片上传接口，若不指定baseurl，可传完整的url
 
 @param image               图片对象
 @param URLString           上传图片的接口路径，如/path/images/
 @param filename            给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 @param name                与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 @param mimeType            默认为image/jpeg
 @param parameters          参数
 @param progress            上传进度
 @param success             上传成功回调
 @param fail                上传失败回调
 @return                    ZJURLSessionTask
 */
+ (ZJURLSessionTask *)uploadWithImage:(UIImage *)image
                            URLString:(NSString *)URLString
                             filename:(NSString *)filename
                                 name:(NSString *)name
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary *)parameters
                             progress:(ZJUploadProgress)progress
                              success:(ZJResponseSuccess)success
                                 fail:(ZJResponseFail)fail;


/**
 上传文件操作
 
 @param URLString             上传路径
 @param uploadingFile   待上传文件的路径
 @param progress        上传进度
 @param success         上传成功回调
 @param fail            上传失败回调
 @return                ZJURLSessionTask
 */
+ (ZJURLSessionTask *)uploadFileWithURLString:(NSString *)URLString
                                uploadingFile:(NSString *)uploadingFile
                                     progress:(ZJUploadProgress)progress
                                      success:(ZJResponseSuccess)success
                                         fail:(ZJResponseFail)fail;



/**
 下载文件
 
 @param URLString 下载URL
 @param saveToPath 下载到哪个路径下
 @param progressBlock 下载进度
 @param success 下载成功后的回调
 @param failure 下载失败后的回调
 @return ZJURLSessionTask
 */
+ (ZJURLSessionTask *)downloadWithURLString:(NSString *)URLString
                                 saveToPath:(NSString *)saveToPath
                                   progress:(ZJDownloadProgress)progressBlock
                                    success:(ZJResponseSuccess)success
                                    failure:(ZJResponseFail)failure;


/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)startNetworkStatusWithBlock:(void(^)(ZJNetworkStatus status))networkStatus;
/**
 * 是否有网
 */
+ (BOOL)isReachable;
/**
 * 是否是蜂窝网络
 */
+ (BOOL)isWWANNetwork;
/**
 * 是否是WIFI
 */
+ (BOOL)isWiFiNetwork;
@end
