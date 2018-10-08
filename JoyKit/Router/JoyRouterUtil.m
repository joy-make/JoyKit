//
//  JoyRouterUtil.m
//  JoyKit
//
//  Created by Joymake on 2018/9/21.
//

#import "JoyRouterUtil.h"

@implementation JoyRouterUtil

#pragma mark 获取地址模块
-(NSString *)getModuleStrFromUrl:(NSURL *)url{
    return url.host;
}

#pragma mark 获取路径
-(NSString *)getPathStrFromUrl:(NSURL *)url{
    if(url.path.length){
        return [url.path hasPrefix:@"/"]?[[url.path componentsSeparatedByString:@"/"] lastObject]:url.path;
    }else{
        return nil;
    }
}

#pragma mark 获取query
-(NSString *)getParamStrFromUrl:(NSURL *)url{
    return  url.query;
}

#pragma mark 解析urlQuery参数
- (NSMutableDictionary *)resolveUrlQuery:(NSURL *)url{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if(url.query){
        NSArray *params = [url.query componentsSeparatedByString:@"&"];
        for (NSString *keyValueStr in params) {
            NSArray *list = [keyValueStr componentsSeparatedByString:@"="];
            if(list.count==2){
                [param setObject:[list.lastObject stringByRemovingPercentEncoding] forKey:list.firstObject];
            }
        }
    }
    return param;
}

#pragma mark para转str
+ (NSString *)JoyQueryStringWithParameters:(NSDictionary *)parameters {
    NSMutableString *query = [NSMutableString string];
    [[parameters allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        NSString *value = [parameters[key] description];
        key = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [query appendFormat:@"%@%@%@%@", (idx > 0) ? @"&" : @"", key, (value.length > 0) ? @"=" : @"", value];
    }];
    return [query copy];
}

- (NSString *)getExcutorWithModule:(NSString *)module path:(NSString *)path{
    NSString *mpath = [[NSBundle mainBundle] pathForResource:module ofType:@"plist"];
    NSDictionary *moduleMap = [NSDictionary dictionaryWithContentsOfFile:mpath];
    NSDictionary *excutorMap = [moduleMap objectForKey:path];
    return [excutorMap objectForKey:@"excutor"];
}

-(JoyRouteActionType)getActionTypeWithModule:(NSString *)module path:(NSString *)path{
    NSString *mpath = [[NSBundle mainBundle] pathForResource:module ofType:@"plist"];
    NSDictionary *moduleMap = [NSDictionary dictionaryWithContentsOfFile:mpath];
    NSDictionary *excutorMap = [moduleMap objectForKey:path];
    NSString *actionType = [excutorMap objectForKey:@"actionType"];
    return actionType?[actionType longLongValue]:JoyRouteActionTypePush;
}

@end
