import 'package:get/get.dart';

import 'package:codeword_analysis/app/modules/home/controllers/add_book_controller.dart';
import 'package:codeword_analysis/app/modules/home/controllers/init_cos_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitCosController>(
      () => InitCosController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut(() => AddBookController());
  }
}
