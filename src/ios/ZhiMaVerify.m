/********* ZhiMaVerify.m Cordova Plugin Implementation *******/
#import <UIKit/UIKit.h>
#import "ZhiMaVerify.h"
#import <ZMCert/ZMCert.h>
#import <AssetsLibrary/AssetsLibrary.h>


#define IsZMCertVideo true

@interface ZhiMaVerify()

@property (weak, nonatomic)  NSString *bizNo;
@property (weak, nonatomic)  NSString *merchantId;
@property (weak, nonatomic) IBOutlet UILabel *resultView;
@end



@implementation ZhiMaVerify

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


- (void) onFinish:(CDVInvokedUrlCommand*) command
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
    ZMCertification *manager = [[ZMCertification alloc] init];
    __weak ZhiMaVerify *weakSelf = self;
    
    NSString* bizNo = [command.arguments objectAtIndex:0];

    
#if IsZMCertVideo
    //  录制动作检测录像
    [manager startVideoWithBizNO:bizNo
                      merchantID:self.merchantId
                       extParams:@{@"RecordVideo" : [NSNumber numberWithBool:YES]}
                  viewController:super.viewController
                        onFinish:^(BOOL isCanceled, BOOL isPassed, ZMStatusErrorType errorCode, NSString * _Nullable videoPath) {
                            CDVPluginResult* pluginResult = nil;
                            if (videoPath) {
                                ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
                                [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:videoPath]
                                                                  completionBlock:^(NSURL *assetURL, NSError *error) {
                                                                      if (error) {
                                                                          NSLog(@"Save video fail:%@",error);
                                                                      } else {
                                                                          NSLog(@"Save video succeed.");
                                                                      }
                                                                  }];
                            }
                            if (isCanceled) {
                                NSLog(@"用户取消了认证");
                                weakSelf.resultView.text = [NSString stringWithFormat:@"用户取消了认证！"];
                                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"cancel"];
                            } else {
                                if (isPassed) {
                                    NSLog(@"认证成功");
                                    weakSelf.resultView.text = [NSString stringWithFormat:@"认证成功"];
                                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"success"];
                                   
                                } else {
                                    NSLog(@"认证失败了 %zi", errorCode);
                                    weakSelf.resultView.text = [NSString stringWithFormat:@"认证中出现问题--%zi", errorCode];
                                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"failed"];
                                }
                            }
                             [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                        }];
#else
    //  不进行动作检测视频录制
    [manager startWithBizNO:bizNo
                 merchantID:self.merchantId
                  extParams:nil
             viewController:self
                   onFinish:^(BOOL isCanceled, BOOL isPassed, ZMStatusErrorType errorCode) {
                        CDVPluginResult* pluginResult = nil;
                       if (isCanceled) {
                           NSLog(@"用户取消了认证");
                           weakSelf.resultView.text = [NSString stringWithFormat:@"用户取消了认证！"];
                           pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"cancel"];
                       }else{
                           if (isPassed) {
                               NSLog(@"认证成功");
                               weakSelf.resultView.text = [NSString stringWithFormat:@"认证成功"];
                               pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"success"];
                           }else{
                               NSLog(@"认证失败了 %zi", errorCode);
                               weakSelf.resultView.text = [NSString stringWithFormat:@"认证中出现问题--%zi", errorCode];
                               pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"failed"];
                           }
                       }
                        [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                   }];
#endif
}
@end
