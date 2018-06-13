/********* AliyunVerify.m Cordova Plugin Implementation *******/

#import "AliyunVerify.h"
#define IsZMCertVideo true



@implementation AliyunVerify

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


#pragma mark - Start Detect
- (IBAction)startCertification:(CDVInvokedUrlCommand*)command {
   
    __weak AliyunVerify *weakSelf = self;
    
    NSString* verifyToken = [command.arguments objectAtIndex:0];

    [RPSDK start:verifyToken rpCompleted:^(AUDIT auditState) {
        NSLog(@"verifyResult = %ld",(unsigned long)auditState);
         CDVPluginResult* pluginResult = nil;
        if(auditState == AUDIT_PASS) { //认证通过
             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:0];
        }
        else if(auditState == AUDIT_FAIL) { //认证不通过
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"1"];
        }
        else if(auditState == AUDIT_IN_AUDIT) { //认证中，通常不会出现，只有在认证审核系统内部出现超时，未在限定时间内返回认证结果时出现。此时提示用户系统处理中，稍后查看认证结果即可。
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"2"];
        }
        else if(auditState == AUDIT_NOT) { //未认证，用户取消
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"3"];
        }
        else if(auditState == AUDIT_EXCEPTION) { //系统异常
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"4"];
        }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }withVC:self.viewController];
}
@end
