var exec = require('cordova/exec');

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'coolMethod', [arg0]);
};
exports.getInstance = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'getInstance', [arg0]);
};
exports.getVersion = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'getVersion', [arg0]);
};
exports.getBuildInfo = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'getBuildInfo', [arg0]);
};
exports.setZMCertificationListener = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'setZMCertificationListener', [arg0]);
};
exports.setZMRecordVideoListener = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'setZMRecordVideoListener', [arg0]);
};
exports.startCertification = function(arg0, success, error) {
    exec(success, error, 'ZhiMaVerify', 'startCertification', [arg0]);
};