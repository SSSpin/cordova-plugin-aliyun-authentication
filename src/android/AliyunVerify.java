package com.aliyun.cordova.verify;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import android.app.Activity;
import android.widget.Toast;

import java.util.HashMap;
import java.util.Random;
import com.alibaba.security.rp.RPSDK;



/**
 * This class echoes a string called from JavaScript.
 */
public class AliyunVerify extends CordovaPlugin {

    private CallbackContext callbackContext;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        RPSDK.initialize(cordova.getActivity().getApplicationContext());


        if (action.equals("coolMethod")) {
            String message = args.getString(0);
            this.coolMethod(message, callbackContext);
            return true;
        }else if(action.equals("getVersion")){
            callbackContext.success("aaaa");
            return true;
        }else if(action.equals("getBuildInfo")){
            callbackContext.success(ZMCertification.getInstance().getBuildInfo());
            return true;
        }else if(action.equals("startCertification")){
            this.callbackContext = callbackContext;

            String token = args.getString(0);
            startCertification(token);
            return true;
        }else if(action.equals("onFinish")){

            return true;
        }else if(action.equals("onRecordVideoFinish")){

            return true;
        }
        return false;
    }

    private void coolMethod(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
    /*
    var2 bizNo
    var3 merchantId
     */
    private void  startCertification(String var2){

        AliyunVerify self = this;
        cordova.getActivity().runOnUiThread(new Runnable() {
            public  void run(){
                RPSDK.start(var2,cordova.getActivity(), new RPSDK.RPCompletedListener() {
                    @Override
                    public void onAuditResult(RPSDK.AUDIT audit) {
                        Toast.makeText(cordova.getActivity(), audit + "", Toast.LENGTH_SHORT).show();
                        if(audit == RPSDK.AUDIT.AUDIT_PASS) { //认证通过
                            self.callbackContext.success(0);
                        }
                        else if(audit == RPSDK.AUDIT.AUDIT_FAIL) { //认证不通过
                            self.callbackContext.error(1);
                        }
                        else if(audit == RPSDK.AUDIT.AUDIT_IN_AUDIT) { //认证中，通常不会出现，只有在认证审核系统内部出现超时，未在限定时间内返回认证结果时出现。此时提示用户系统处理中，稍后查看认证结果即可。
                            self.callbackContext.error(2);
                        }
                        else if(audit == RPSDK.AUDIT.AUDIT_NOT) { //未认证，用户取消
                            self.callbackContext.error(3);
                        }
                        else if(audit == RPSDK.AUDIT.AUDIT_EXCEPTION){ //系统异常
                            self.callbackContext.error(4);
                        }
                    }
                });
            }
        });


    }

}
