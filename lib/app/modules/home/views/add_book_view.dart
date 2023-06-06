import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/modules/home/controllers/add_book_controller.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

class AddBookView extends StatefulWidget {
  final Book? book;
  const AddBookView({super.key, this.book});

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  final controller = Get.find<AddBookController>();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      controller.bookNameController.text = widget.book!.bookName;
      controller.bookWordCountController.text =
          widget.book!.bookWordCount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.book == null ? "添加书籍" : "编辑书籍"),
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
                Get.back(
                  result: Book(
                    Uuid.v4(),
                    controller.bookNameController.text,
                    JSON(controller.bookWordCountController.text).intValue,
                  ),
                );
              },
              child: Text(widget.book == null ? "添加" : "保存"),
            ),
          )
        ],
      ),
    );
  }
}
