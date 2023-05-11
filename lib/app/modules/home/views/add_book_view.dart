import 'package:codeword_analysis/app/modules/home/controllers/add_book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBookView extends GetView<AddBookController> {
  final VoidCallback onAddPressed;
  const AddBookView({super.key, required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("新增书籍"),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 70, child: Text("名称")),
              Expanded(
                child: TextField(
                  controller: controller.bookNameController,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 70, child: Text("预计字数")),
              Expanded(
                child: TextField(
                  controller: controller.bookWordCountController,
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                onAddPressed();
              },
              child: const Text("添加"),
            ),
          )
        ],
      ),
    );
  }
}
