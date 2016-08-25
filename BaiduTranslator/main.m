//
//  main.m
//  BaiduTranslator
//
//  Created by ants on 16/8/25.
//  Copyright © 2016年 ants. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFNetworking.h"
#import "YWCTool.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *path = @"/Users/ants/Desktop/fasdfadsfasdf.html";
        bool exist = [fm fileExistsAtPath:path];
        if (exist == false) {
            exit(-1);
        }
        NSMutableString *mutableContent = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        if (mutableContent == nil) {
            exit(-2);
        }
        
        NSUInteger startLocation = 0;
        while (1) {
            NSRange backRange = [mutableContent rangeOfString:@"\";" options:0 range:NSMakeRange(startLocation, mutableContent.length - startLocation)];
            if (backRange.location == NSNotFound) {
                break;
            }
            startLocation += (backRange.location - startLocation);
            startLocation += 2;
            
            NSRange frontRange = [mutableContent rangeOfString:@"\"" options:NSBackwardsSearch range:NSMakeRange(0, backRange.location-1/*要不要－1*/)];
            NSRange needTranslationRange = NSMakeRange(frontRange.location+1, backRange.location - (frontRange.location + 1));
            NSString *needTranlationString = [mutableContent substringWithRange:needTranslationRange];
            NSLog(@"%@",needTranlationString);
            
            
            NSString *afterTranslationString = @"翻译后的string";
            [mutableContent replaceCharactersInRange:needTranslationRange withString:afterTranslationString];
            startLocation = (startLocation - needTranslationRange.length + afterTranslationString.length);
            NSLog(@"%@",mutableContent);
            
           
            
            

        }
        
        
//        NSNumber *appID = @20160825000027431;
//        NSString *secret = @"Mi_MQ_2JaIDO4MpX37YU";
//        NSNumber *salt = [NSNumber numberWithInteger:arc4random()%10000];
//        NSString *q = @"我爱你";
//        NSString *signBeforeMD5 = [NSString stringWithFormat:@"%@%@%@%@",appID,q,salt,secret];
//        ;
//        NSString *sign = [YWCTool getmd5WithString:signBeforeMD5];
//        NSDictionary *parameters = @{
//                                     @"q":q,
//                                     @"from":@"zh",
//                                     @"to":@"en",
//                                     @"appid":appID,
//                                     @"salt":salt,
//                                     @"sign":sign
//                                     };
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        [manager GET:@"http://api.fanyi.baidu.com/api/trans/vip/translate" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            NSLog(@"%@",responseObject);
//        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//            NSLog(@"error-> %@",error);
//        }];
        
        
    }
    return 0;
}
