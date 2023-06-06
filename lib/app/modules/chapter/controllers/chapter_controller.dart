import 'package:codeword_analysis/app/common/utils.dart';
import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/data/realm/realm_controller.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

class ChapterController extends GetxController {
  late Book book;
  late Realm realm;

  var chapters = <Chapter>[].obs;

  final TextEditingController chapterWordCountTextController =
      TextEditingController();
  // 发布日期
  var publicTime = DateTime.now().obs;

  ChapterController() {
    book = Get.arguments;
    realm = Get.find<RealmController>().realm;
    loadChapters();
  }

  void loadChapters() {
    // RealmResults<Chapter> results = realm.query<Chapter>(
    //     'book == \$0', [book]);
    //     res
    var chapterList = realm.query<Chapter>('book == \$0', [book]).toList();
    chapterList.sort((a, b) => b.chapterIndex.compareTo(a.chapterIndex));
    chapters.value = chapterList;
  }

  void onAdd() {
    final chapterWordCount = int.tryParse(chapterWordCountTextController.text);
    if (chapterWordCount == null) {
      Get.snackbar("错误!", "字数为空!");
      return;
    }
    RealmResults<Chapter> chapters =
        realm.query<Chapter>('book == \$0', [book]);

    Chapter chapter = Chapter(
      Uuid.v4(),
      chapters.length + 1,
      chapterWordCount,
      publicTime.value.millisecondsSinceEpoch,
      book: book,
    );

    EditHistory editHistory = EditHistory(
      Uuid.v4(),
      publicTime.value.millisecondsSinceEpoch,
      chapterWordCount,
      chapter: chapter,
    );
    realm.write(() {
      realm.add(chapter);
      realm.add(editHistory);
    });
    loadChapters();
    chapterWordCountTextController.clear();
    reloadEditDayDescription(realm, book, dateTime: publicTime.value);
  }

  String getPublicTimeString() {
    return formatDate(publicTime.value, [yyyy, "-", mm, "-", dd]);
  }

  Future<void> selectPublicDateTime(BuildContext context) async {
    DateTime? time = await showDatePickerDialog(context);
    if (time == null) return;
    publicTime.value = time;
  }

  void removeChapter(Chapter chapter) {
    realm.write(() {
      realm.delete(chapter);
    });
    loadChapters();
  }
}
