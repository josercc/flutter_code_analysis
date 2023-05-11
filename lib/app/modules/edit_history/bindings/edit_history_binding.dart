import 'package:get/get.dart';
import '../controllers/edit_history_controller.dart';

class EditHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditHistoryController>(
      () => EditHistoryController(),
    );
  }
}
