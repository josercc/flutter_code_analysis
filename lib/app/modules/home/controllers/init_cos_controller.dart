import 'package:codeword_analysis/app/common/tencent_cos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';

class InitCosController extends GetxController {
  final TextEditingController serectIdController = TextEditingController();
  final TextEditingController serectKeyController = TextEditingController();

  Future<void> saveSocConfig() async {
    SVProgressHUD.show();
    String serectId = serectIdController.text;
    String serectKey = serectKeyController.text;
    if (serectId.isEmpty || serectKey.isEmpty) {
      Get.snackbar("错误!", "密钥为空!");
      return;
    }
    await TencentCos.instance.setTencentSerect(serectId, serectKey);
    await TencentCos.instance.initCos();
    SVProgressHUD.dismiss();
  }
}
