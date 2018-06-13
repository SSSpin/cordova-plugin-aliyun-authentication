//
//  AliyunVerify.h
//  Fingo_
//
//  Created by ljl on 2018/6/7.
//


#define AliyunVerify_h
#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <RPSDK/RPSDK.h>

@interface AliyunVerify : CDVPlugin{
    @private
    CDVInvokedUrlCommand* _command;
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (IBAction) startCertification:(CDVInvokedUrlCommand*)command;

@end




