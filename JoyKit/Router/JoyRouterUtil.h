//
//  JoyRouterUtil.h
//  JoyKit
//
//  Created by Joymake on 2018/9/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JoyRouterUtil : NSObject
/**
 *  获取地址中模块名
 *
 *  @param url 地址
 *
 *  @return 返回模块名
 */
- (NSString *)getModuleStrFromUrl:(NSURL *)url;

/**
 *  获取地址中路径名
 *
 *  @param url 地址
 *
 *  @return 返回路径名
 */
- (NSString *)getPathStrFromUrl:(NSURL *)url;

/**
 *  获取地址中参数内容（json字符串）
 *
 *  @param url url 地址
 *
 *  @return 参数内容（json字符串）
 */
- (NSString *)getParamStrFromUrl:(NSURL *)url;

/**
 解析url参数
 @param url url地址
 @return url解析参数。 title=personDetail,action=updateAction
 */
- (NSMutableDictionary *)resolveUrlQuery:(NSURL *)url;

/**
 拼接参数为字符串
 @param parameters 参数
 @return 拼接结果
 */
+ (NSString *)JoyQueryStringWithParameters:(NSDictionary *)parameters;

/**
 查找执行文件
 @param module 模块名称
 @param path 执行路径
 @return 执行类名
 */
- (NSString *)getExcutorWithModule:(NSString *)module path:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
