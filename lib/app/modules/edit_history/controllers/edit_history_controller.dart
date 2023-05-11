import 'package:codeword_analysis/app/common/utils.dart';
import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/modules/edit_history/controllers/date_history_controller.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

import '../../../data/realm/realm_controller.dart';

class EditHistoryController extends GetxController {
  late Book book;
  late Realm realm;
  var times = <DateTime>[].obs;

  EditHistoryController() {
    realm = Get.find<RealmController>().realm;
    book = Get.arguments;
    for (var i = 0; i < 10; i++) {
      DateTime dateTime = DateTime.now().subtract(Duration(days: i));
      times.add(dateTime);
      Get.lazyPut<DateHistoryController>(
        () => DateHistoryController(book, dateTime),
        tag: getChapterDateString(dateTime),
      );
    }
  }

  void onLoad() {
    for (var i = 0; i < 10; i++) {
      DateTime dateTime = DateTime.now().subtract(Duration(days: times.length));
      times.add(dateTime);
      Get.lazyPut<DateHistoryController>(
        () => DateHistoryController(book, dateTime),
        tag: getChapterDateString(dateTime),
      );
    }
  }
}
