//
//  main.m
//  BaiduTranslator
//
//  Created by ants on 16/8/25.
//  Copyright © 2016年 ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "YWCTool.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        NSNumber *appID = @20160825000027431;
        NSString *secret = @"Mi_MQ_2JaIDO4MpX37YU";
        NSNumber *salt = [NSNumber numberWithInteger:arc4random()%10000];
        NSString *q = @"我爱你";
        NSString *signBeforeMD5 = [NSString stringWithFormat:@"%@%@%@%@",appID,q,salt,secret];
        ;
        NSString *sign = [YWCTool getmd5WithString:signBeforeMD5];
        NSDictionary *parameters = @{
                                     @"q":q,
                                     @"from":@"zh",
                                     @"to":@"en",
                                     @"appid":appID,
                                     @"salt":salt,
                                     @"sign":sign
                                     };
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://api.fanyi.baidu.com/api/trans/vip/translate" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"error-> %@",error);
        }];
        
        
    }
    return 0;
}
