import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../data/realm/book.dart';

Future<DateTime?> showDatePickerDialog(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(const Duration(days: 365)),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    // locale: const Locale("nun"),
  );
}

String getChapterDateString(DateTime time) {
  return formatDate(time, [yyyy, "-", mm, "-", dd]);
}

void reloadEditDayDescription(Realm realm, Book book, {DateTime? dateTime}) {
  // 查询当前没有发布的章节
  var chapters = realm.query<Chapter>('book == \$0', [book]);
  // 未发布的次数
  int noPublishCount = chapters.where((element) => !element.isPublished).fold(
      0, (previousValue, element) => previousValue + element.chapterWordCount);
  // 总共字数
  int totalCount = chapters.fold(
      0, (previousValue, element) => previousValue + element.chapterWordCount);
  String dateText = getChapterDateString(dateTime ?? DateTime.now());
  // 查询是否存在当天的修改记录
  var editDayDescriptions = realm.query<EditDayDescription>(
      'book == \$0 AND date == \$1', [book, dateText]);
  if (editDayDescriptions.isEmpty) {
    EditDayDescription description = EditDayDescription(
        Uuid.v4(), noPublishCount, totalCount, dateText,
        book: book);
    realm.write(() => realm.add(description));
  } else {
    EditDayDescription description = editDayDescriptions.first;
    realm.write(() {
      description.noPublishCount = noPublishCount;
      description.totalCount = totalCount;
    });
  }
}
