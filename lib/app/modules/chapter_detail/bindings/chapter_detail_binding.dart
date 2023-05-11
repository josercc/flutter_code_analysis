import 'package:get/get.dart';

import '../controllers/chapter_detail_controller.dart';

class ChapterDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChapterDetailController>(
      () => ChapterDetailController(),
    );
  }
}
