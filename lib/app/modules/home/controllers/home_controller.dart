import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/data/realm/realm_controller.dart';
import 'package:codeword_analysis/app/modules/home/controllers/add_book_controller.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

class HomeController extends GetxController {
  /// 全部书籍
  var books = <Book>[].obs;
  late Realm realm;
  late AddBookController addBookController;

  HomeController() {
    realm = Get.find<RealmController>().realm;
    addBookController = Get.find<AddBookController>();
    books.value = realm.all<Book>().toList();
  }

  void onAdd() {
    final bookName = addBookController.bookNameController.text;
    final bookWordCount =
        int.tryParse(addBookController.bookWordCountController.text);
    if (bookName.isEmpty || bookWordCount == null) {
      Get.snackbar("错误!", "用户名或者字数为空");
      return;
    }
    var dbBooks = realm.query<Book>('bookName == \$0', [bookName]);
    if (dbBooks.isNotEmpty) {
      Get.snackbar("", "$bookName已经存在!");
      return;
    }
    Book book = Book(Uuid.v4(), bookName, bookWordCount);
    realm.write(() {
      realm.add(book);
    });
    _reloadBooks();
    addBookController.bookNameController.clear();
    addBookController.bookWordCountController.clear();
  }

  void _reloadBooks() {
    books.value = realm.all<Book>().toList();
  }

  void removeBook(Book book) {
    realm.write(() => realm.delete(book));
    _reloadBooks();
  }
}
