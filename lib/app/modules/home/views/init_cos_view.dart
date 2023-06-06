import 'package:codeword_analysis/app/modules/home/controllers/init_cos_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InitCosView extends GetView<InitCosController> {
  const InitCosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('腾讯 SOC 配置', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(
              controller: controller.serectIdController,
              decoration: const InputDecoration(hintText: "请输入 Serect Id"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.serectKeyController,
              decoration: const InputDecoration(hintText: "请输入 Serect Key"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.back();
                controller.saveSocConfig();
              },
              child: const Text("确定"),
            )
          ],
        ),
      ),
    );
  }
}
