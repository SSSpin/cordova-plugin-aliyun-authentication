var exec = require('cordova/exec');

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'coolMethod', [arg0]);
};
exports.getInstance = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'ZMCertification.getInstance', [arg0]);
};
exports.getVersion = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'ZMCertification.getVersion', [arg0]);
};
exports.getBuildInfo = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'ZMCertification.getBuildInfo', [arg0]);
};
exports.setZMCertificationListener = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'ZMCertification.setZMCertificationListener', [arg0]);
};
exports.setZMRecordVideoListener = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'ZMCertification.setZMRecordVideoListener', [arg0]);
};
exports.startCertification = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'ZMCertification.startCertification', [arg0]);
};