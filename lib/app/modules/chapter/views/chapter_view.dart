import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/modules/chapter/views/add_chapter_view_view.dart';
import 'package:codeword_analysis/app/routes/app_pages.dart';
import 'package:codeword_analysis/app/widgets/delete_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chapter_controller.dart';

class ChapterView extends GetView<ChapterController> {
  const ChapterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('章节列表'), centerTitle: true, actions: [
        IconButton(
          onPressed: () {
            Get.toNamed(Routes.EDIT_HISTORY, arguments: controller.book);
          },
          icon: const Icon(Icons.history),
        ),
        IconButton(
          onPressed: _add,
          icon: const Icon(Icons.add),
        )
      ]),
      body: Obx(
        () => ListView.separated(
          itemBuilder: (context, index) {
            Chapter chapter = controller.chapters[index];
            return DeleteWidget(
              deleteKey: ObjectKey(chapter),
              onDismissed: () {
                controller.removeChapter(chapter);
              },
              child: InkWell(
                onTap: () async {
                  await Get.toNamed(Routes.CHAPTER_DETAIL, arguments: chapter);
                  controller.loadChapters();
                },
                child: Container(
                  color: chapter.isPublished
                      ? Colors.grey[400]
                      : Colors.green[100],
                  child: ListTile(
                    title: Text("第 ${chapter.chapterIndex} 章"),
                    subtitle: Text("章节字数:${chapter.chapterWordCount}"),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: controller.chapters.length,
        ),
      ),
    );
  }

  void _add() {
    Get.dialog(const Dialog(child: AddChapterViewView()));
  }
}
