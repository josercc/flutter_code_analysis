import 'package:codeword_analysis/app/common/utils.dart';
import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/data/realm/realm_controller.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

class DateHistoryController extends GetxController {
  Book book;
  DateTime dateTime;
  late Realm realm;

  var historys = <EditHistory>[].obs;
  var description = "".obs;

  DateHistoryController(this.book, this.dateTime) {
    realm = Get.find<RealmController>().realm;
    historys.value = realm.all<EditHistory>().query(
      "chapter.book==\$0",
      [book],
    ).where(
      (element) {
        return getChapterDateString(
                DateTime.fromMillisecondsSinceEpoch(element.timeInterval)) ==
            getChapterDateString(dateTime);
      },
    ).toList();
    _updateDayDescription();
  }

  String editHistoryDescription(EditHistory history) {
    String dateTimeString = formatDate(
        DateTime.fromMillisecondsSinceEpoch(history.timeInterval),
        [yyyy, "-", mm, "-", dd, " ", hh, ":", nn, ":", dd]);
    StringBuffer stringBuffer =
        StringBuffer("第 ${history.chapter?.chapterIndex}章");
    if (history.wordCount > 0) {
      stringBuffer.write(" +${history.wordCount}字");
    } else {
      stringBuffer.write(" -${history.wordCount}字");
    }
    stringBuffer.write(" $dateTimeString");
    return stringBuffer.toString();
  }

  void _updateDayDescription() {
    RealmResults<EditDayDescription> editHistoryDescriptions = realm
        .query<EditDayDescription>("book == \$0 AND date == \$1",
            [book, getChapterDateString(dateTime)]);
    if (editHistoryDescriptions.isEmpty) return;
    int remainCount =
        book.bookWordCount - editHistoryDescriptions.first.totalCount;
    description.value =
        "${getChapterDateString(dateTime)} 码字:$_editCount,目前剩余存稿字数:${editHistoryDescriptions.first.noPublishCount}, 总字数:${editHistoryDescriptions.first.totalCount}。${remainCount > 0 ? "距离目标还有$remainCount字" : "超出目标$remainCount字"}";
  }

  int get _editCount => historys.fold(
      0, (previousValue, element) => previousValue + element.wordCount);
}
