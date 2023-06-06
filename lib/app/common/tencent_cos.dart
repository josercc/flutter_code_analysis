import 'dart:async';

import 'package:codeword_analysis/app/data/realm/realm_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tencentcloud_cos_sdk_plugin/cos.dart';
import 'package:tencentcloud_cos_sdk_plugin/cos_transfer_manger.dart';
import 'package:tencentcloud_cos_sdk_plugin/pigeon.dart';
import 'package:tencentcloud_cos_sdk_plugin/transfer_task.dart';

class TencentCos {
  static TencentCos instance = TencentCos._();
  TencentCos._();

  String _tencentSercetId = "";
  String _tencentSercetKey = "";
  String tencentBucket = "josercc-1257328378";
  Cos cos = Cos();
  CosXmlServiceConfig config = CosXmlServiceConfig(
    region: "ap-chengdu",
    isDebuggable: true,
    isHttps: true,
  );

  bool _isReadly = false;
  bool get isReadly => _isReadly;

  String? _uploadId;

  Future<void> initCos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _tencentSercetId = preferences.getString("_tencentSercetId") ?? "";
    _tencentSercetKey = preferences.getString("_tencentSercetKey") ?? "";
    if (_tencentSercetId.isEmpty || _tencentSercetKey.isEmpty) {
      return;
    }
    cos.initWithPlainSecret(_tencentSercetId, _tencentSercetKey);
    // 注册默认 COS Service
    await cos.registerDefaultService(config);

    // 创建 TransferConfig 对象，根据需要修改默认的配置参数
    // TransferConfig 可以设置智能分块阈值 默认对大于或等于2M的文件自动进行分块上传，可以通过如下代码修改分块阈值
    TransferConfig transferConfig = TransferConfig(
      forceSimpleUpload: false,
      enableVerification: true,
      divisionForUpload: 2097152, // 设置大于等于 2M 的文件进行分块上传
      sliceSizeForUpload: 1048576, //设置默认分块大小为 1M
    );
    // 注册默认 COS TransferManger
    await cos.registerDefaultTransferManger(config, transferConfig);
    _isReadly = true;
    debugPrint("初始化 Cos 成功");
  }

  Future<void> setTencentSerect(String id, String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("_tencentSercetId", id);
    preferences.setString("_tencentSercetKey", key);
  }

  Future<void> upload(String cosPath, String filePath) async {
    if (!isReadly) {
      if (_tencentSercetId.isEmpty || _tencentSercetKey.isEmpty) {
        return;
      }
      await initCos();
    }
    _uploadId = null;
    SVProgressHUD.show();
    CosTransferManger cosTransferManger = cos.getDefaultTransferManger();
    await cosTransferManger.upload(
      tencentBucket,
      cosPath,
      filePath: filePath,
      uploadId: _uploadId,
      resultListener: ResultListener(
        (success) {
          SVProgressHUD.showSuccess(status: "上传成功");
          SVProgressHUD.dismiss(delay: const Duration(seconds: 2));
        },
        (clientException, serviceException) {
          if (clientException != null) {
            SVProgressHUD.showError(status: clientException.message);
          } else if (serviceException != null) {
            SVProgressHUD.showError(status: serviceException.errorMessage);
          }
          SVProgressHUD.dismiss(delay: const Duration(seconds: 2));
        },
      ),
      progressCallBack: (complete, target) {
        // 计算上传百分比
        double percent = complete / target;
        SVProgressHUD.showProgress(percent);
      },
      initMultipleUploadCallback: (bucket, cosKey, uploadId) {
        _uploadId = uploadId;
      },
    );
  }

  Future<bool> download(String cosPath, String filePath) async {
    Completer<bool> completer = Completer<bool>();
    SVProgressHUD.show();
    CosTransferManger transferManger = cos.getDefaultTransferManger();
    await transferManger.download(
      tencentBucket,
      cosPath,
      filePath,
      resultListener: ResultListener(
        (success) {
          SVProgressHUD.showSuccess(status: "下载成功");
          SVProgressHUD.dismiss(
            delay: const Duration(seconds: 2),
            completion: () {
              completer.complete(true);
            },
          );
        },
        (clientException, serviceException) {
          if (clientException != null) {
            SVProgressHUD.showError(status: clientException.message);
          } else if (serviceException != null) {
            SVProgressHUD.showError(status: serviceException.errorMessage);
          }
          SVProgressHUD.dismiss(
            delay: const Duration(seconds: 2),
            completion: () {
              completer.complete(false);
            },
          );
        },
      ),
      progressCallBack: (complete, target) {
        SVProgressHUD.showProgress(complete / target);
      },
    );
    return completer.future;
  }
}
