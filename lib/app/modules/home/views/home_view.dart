import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/modules/home/views/add_book_view.dart';
import 'package:codeword_analysis/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('书籍列表'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _add,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Obx(
        () => ListView.separated(
          itemBuilder: (context, index) {
            Book book = controller.books[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.CHAPTER, arguments: book);
              },
              child: Dismissible(
                key: ObjectKey(book),
                onDismissed: (direction) {
                  controller.removeBook(book);
                },
                child: Container(
                  color: Colors.green[100],
                  child: ListTile(
                    title: Text(book.bookName),
                    subtitle: Text("预测字数:${book.bookWordCount}"),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: controller.books.length,
        ),
      ),
    );
  }

  void _add() {
    Get.dialog(Dialog(child: AddBookView(onAddPressed: controller.onAdd)));
  }
}
