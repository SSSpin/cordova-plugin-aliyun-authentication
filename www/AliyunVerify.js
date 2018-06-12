var exec = require('cordova/exec');

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, 'AliyunVerify', 'coolMethod', [arg0]);
};
exports.getInstance = function(arg0, success, error) {
    exec(success, error, 'AliyunVerify', 'getInstance', [arg0]);
};
exports.getVersion = function(arg0, success, error) {
    exec(success, error, 'AliyunVerify', 'getVersion', [arg0]);
};
exports.getBuildInfo = function(arg0, success, error) {
    exec(success, error, 'AliyunVerify', 'getBuildInfo', [arg0]);
};
exports.setZMCertificationListener = function(arg0, success, error) {
    exec(success, error, 'AliyunVerify', 'setZMCertificationListener', [arg0]);
};
exports.setZMRecordVideoListener = function(arg0, success, error) {
    exec(success, error, 'AliyunVerify', 'setZMRecordVideoListener', [arg0]);
};
exports.startCertification = function(arg0, success, error) {
    exec(success, error, 'AliyunVerify', 'startCertification', [arg0]);
};