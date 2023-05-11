import 'package:codeword_analysis/app/modules/chapter/controllers/chapter_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddChapterViewView extends GetView<ChapterController> {
  const AddChapterViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("添加章节"),
          const SizedBox(height: 10),
          Row(children: [
            const Text("章节字数:"),
            Expanded(
              child: TextField(
                controller: controller.chapterWordCountTextController,
                keyboardType: TextInputType.number,
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            const Text("发布日期:"),
            Expanded(
              child: InkWell(
                onTap: () => controller.selectPublicDateTime(context),
                child: Obx(
                  () => TextField(
                    enabled: false,
                    controller: TextEditingController(
                      text: controller.getPublicTimeString(),
                    ),
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                controller.onAdd();
              },
              child: const Text("添加"),
            ),
          )
        ],
      ),
    );
  }
}
