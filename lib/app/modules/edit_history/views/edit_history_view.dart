import 'package:codeword_analysis/app/common/utils.dart';
import 'package:codeword_analysis/app/modules/edit_history/views/date_history_view_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_history_controller.dart';

class EditHistoryView extends GetView<EditHistoryController> {
  const EditHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改历史'),
        centerTitle: true,
      ),
      body: EasyRefresh(
        onLoad: () {
          controller.onLoad();
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Obx(() => ListView.separated(
                itemBuilder: (context, index) {
                  DateTime time = controller.times[index];
                  return DateHistoryViewView(dateTime: time);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.times.length,
              )),
        ),
      ),
    );
  }
}
