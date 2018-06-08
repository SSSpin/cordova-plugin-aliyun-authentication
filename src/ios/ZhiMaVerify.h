//
//  ZhiMaVerify.h
//  Fingo_
//
//  Created by ljl on 2018/6/7.
//


#define ZhiMaVerify_h
#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
@interface ZhiMaVerify : CDVPlugin{
    @private
    CDVInvokedUrlCommand* _command;
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (IBAction) startCertification:(CDVInvokedUrlCommand*)command;
- (void) onFinish:(CDVInvokedUrlCommand*)command;

@end




