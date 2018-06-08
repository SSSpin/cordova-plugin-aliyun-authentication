package com.zhima.cordova.verify;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import android.app.Activity;
import android.widget.Toast;

import java.util.HashMap;
import java.util.Random;
import com.zmxy.ZMCertification;
import com.zmxy.ZMCertificationListener;

/**
 * This class echoes a string called from JavaScript.
 */
public class ZhiMaVerify extends CordovaPlugin implements ZMCertificationListener {

    private CallbackContext callbackContext;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
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
        }else if(action.equals("setZMCertificationListener")){

            return true;
        }else if(action.equals("setZMRecordVideoListener")){

            return true;
        }else if(action.equals("startCertification")){
            this.callbackContext = callbackContext;

            String bizNo = args.getString(0);
            startCertification(bizNo,"merchannt_Id");
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
    private void  startCertification(String var2, String var3){
        //set listener
        ZMCertification.getInstance().setZMCertificationListener(ZhiMaVerify.this);
        //start certification
        ZMCertification.getInstance().startCertification(cordova.getActivity(), var2, var3, null);
    }

    @Override
    public void onFinish(boolean isCanceled, boolean isPassed, int errorCode) {
        Boolean ispassed = isPassed;
        Boolean iscanceled = isCanceled;
        ZMCertification.getInstance().setZMCertificationListener(null);
        this.callbackContext.success(ispassed.toString());
    }

}
