import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/modules/home/views/add_book_view.dart';
import 'package:codeword_analysis/app/routes/app_pages.dart';
import 'package:codeword_analysis/app/widgets/delete_widget.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
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
        leading: Row(
          children: [
            IconButton(
              onPressed: () => controller.importBackup(),
              icon: const Icon(Icons.import_export),
            ),
            IconButton(
              onPressed: () => controller.saveBackup(),
              icon: const Icon(Icons.save),
            )
          ],
        ),
        leadingWidth: 110,
      ),
      body: Obx(
        () => ListView.separated(
          itemBuilder: (context, index) {
            Book book = controller.books[index];
            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.CHAPTER, arguments: book);
                  },
                  child: DeleteWidget(
                    onDismissed: () => controller.removeBook(book),
                    deleteKey: ObjectKey(book),
                    child: Container(
                      color: Colors.green[100],
                      child: ListTile(
                        title: Text(book.bookName),
                        subtitle: Text("预测字数:${book.bookWordCount}"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(
                    // color: Colors.red,
                    width: 70,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                      ),
                      onPressed: () => _edit(book),
                    ),
                  ),
                )
              ],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: controller.books.length,
        ),
      ),
    );
  }

  void _add() async {
    final book = await Get.dialog<Book>(Dialog(child: AddBookView()));
    if (book != null) {
      controller.onAdd(book);
    }
  }

  void _edit(Book book) async {
    final editBook = await Get.dialog<Book>(
      Dialog(child: AddBookView(book: book)),
    );
    if (editBook != null) {
      controller.onEdit(book, editBook);
    }
  }
}
