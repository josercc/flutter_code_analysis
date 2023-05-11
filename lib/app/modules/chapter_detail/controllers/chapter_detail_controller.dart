import 'package:codeword_analysis/app/common/utils.dart';
import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

import '../../../data/realm/realm_controller.dart';

class ChapterDetailController extends GetxController {
  late Realm realm;
  late Chapter chapter;

  final TextEditingController chapterWordCountTextController =
      TextEditingController();
  final TextEditingController publishTimeTextController =
      TextEditingController();

  var isPublish = false.obs;

  var dateTime = DateTime.now().obs;

  ChapterDetailController() {
    realm = Get.find<RealmController>().realm;
    chapter = Get.arguments;

    chapterWordCountTextController.text = chapter.chapterWordCount.toString();
    dateTime.value = DateTime.fromMillisecondsSinceEpoch(chapter.timeInterval);
    publishTimeTextController.text =
        _formatDate(DateTime.fromMillisecondsSinceEpoch(chapter.timeInterval));
    isPublish.value = chapter.isPublished;
  }

  String _formatDate(DateTime date) {
    return formatDate(date, [
      yyyy,
      "-",
      mm,
      "-",
      dd,
      " ",
      hh,
      ":",
      nn,
      ":",
      dd,
    ]);
  }

  void updateTime(DateTime time) {
    dateTime.value = time;
  }

  void save() {
    final chapterWordCount = int.tryParse(chapterWordCountTextController.text);
    if (chapterWordCount == null) {
      Get.snackbar("错误!", "章节名或者字数为空");
      return;
    }

    int editCount = chapterWordCount - chapter.chapterWordCount;
    if (editCount != 0) {
      EditHistory editHistory = EditHistory(
        Uuid.v4(),
        dateTime.value.millisecondsSinceEpoch,
        editCount,
        chapter: chapter,
      );
      realm.write(() {
        realm.add(editHistory);
      });
    }

    realm.write(() {
      chapter.chapterWordCount = chapterWordCount;
      chapter.isPublished = isPublish.value;
      chapter.timeInterval = dateTime.value.millisecondsSinceEpoch;
    });
    Get.back();
    reloadEditDayDescription(realm, chapter.book!, dateTime: dateTime.value);
  }
}
