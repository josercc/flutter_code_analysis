import 'package:codeword_analysis/app/common/tencent_cos.dart';
import 'package:codeword_analysis/app/data/realm/realm_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(RealmController());
      }),
    ),
  );
}
