import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/utils.dart';
import '../controllers/chapter_detail_controller.dart';

class ChapterDetailView extends GetView<ChapterDetailController> {
  const ChapterDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第 ${controller.chapter.chapterIndex} 章'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(children: [
              const Text("章节字数:"),
              Expanded(
                  child: TextField(
                controller: controller.chapterWordCountTextController,
              )),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              const Text("是否发布:"),
              Obx(
                () => Switch(
                  value: controller.isPublish.value,
                  onChanged: (value) {
                    controller.isPublish.value = value;
                  },
                ),
              )
            ]),
            const SizedBox(height: 10),
            Row(children: [
              const Text("发布时间:"),
              Expanded(
                child: InkWell(
                  onTap: () => _showDatePicker(context),
                  child: Obx(() => TextField(
                        controller: TextEditingController(
                            text: getChapterDateString(
                                controller.dateTime.value)),
                        enabled: false,
                      )),
                ),
              ),
            ]),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.save,
                child: const Text("修改章节"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime? time = await showDatePickerDialog(context);
    if (time != null) {
      controller.updateTime(time);
    }
  }
}
