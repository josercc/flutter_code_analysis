import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/modules/edit_history/controllers/date_history_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pasteboard/pasteboard.dart';

import '../../../common/utils.dart';

class DateHistoryViewView extends GetView<DateHistoryController> {
  final DateTime dateTime;
  const DateHistoryViewView({Key? key, required this.dateTime})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Pasteboard.writeText(controller.description.value);
        Get.snackbar("复制完成!", "");
      },
      child: ExpandablePanel(
        header: ListTile(
          title: Text(getChapterDateString(dateTime)),
          subtitle: Obx(() => Text(controller.description.value)),
        ),
        collapsed: Container(),
        expanded: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              controller.historys.length,
              (index) {
                var history = controller.historys[index];
                return ListTile(
                  leading: Text(controller.editHistoryDescription(history)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  DateHistoryController get controller =>
      Get.find(tag: getChapterDateString(dateTime));
}
