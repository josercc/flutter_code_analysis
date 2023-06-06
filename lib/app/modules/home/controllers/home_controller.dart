import 'package:codeword_analysis/app/common/tencent_cos.dart';
import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:codeword_analysis/app/data/realm/realm_controller.dart';
import 'package:codeword_analysis/app/modules/home/controllers/add_book_controller.dart';
import 'package:codeword_analysis/app/modules/home/controllers/init_cos_controller.dart';
import 'package:codeword_analysis/app/modules/home/views/init_cos_view.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

class HomeController extends GetxController {
  /// 全部书籍
  var books = <Book>[].obs;
  late AddBookController addBookController;
  static const String icloudContainer = "iCloud:realm_db_container";

  InitCosController initCosController = Get.put(InitCosController());

  HomeController() {
    addBookController = Get.find<AddBookController>();
    books.value = realm.all<Book>().toList();

    TencentCos.instance.initCos();
  }

  void onAdd(Book book) {
    if (book.bookName.isEmpty || book.bookWordCount == 0) {
      Get.snackbar("错误!", "用户名或者字数为空");
      return;
    }
    var dbBooks = realm.query<Book>('bookName == \$0', [book.bookName]);
    if (dbBooks.isNotEmpty) {
      Get.snackbar("", "${book.bookName}已经存在!");
      return;
    }
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

  void onEdit(Book book, Book editBook) {
    realm.write(() {
      book.bookName = editBook.bookName;
      book.bookWordCount = editBook.bookWordCount;
    });
    _reloadBooks();
  }

  // 保存备份
  void saveBackup() async {
    if (!TencentCos.instance.isReadly) {
      SVProgressHUD.showError(status: "你还没有初始化服务,请配置服务密钥!");
      SVProgressHUD.dismiss(
          delay: const Duration(seconds: 2), completion: () => initCos());
      return;
    }
    final isSave = await Get.defaultDialog<bool>(
      title: "确定要备份当前数据?",
      middleText: "",
      onCancel: () => Get.back(result: false),
      onConfirm: () => Get.back(result: true),
    );
    if (!JSON(isSave).boolValue) return;
    String cosPath = "code_analyzer_realm_db";
    String filePath = Get.find<RealmController>().realm.config.path;

    await TencentCos.instance.upload(cosPath, filePath);
  }

  // 导出备份
  void importBackup() async {
    if (!TencentCos.instance.isReadly) {
      SVProgressHUD.showError(status: "你还没有初始化服务,请配置服务密钥!");
      SVProgressHUD.dismiss(
        delay: const Duration(seconds: 2),
        completion: () => initCos(),
      );
      return;
    }
    final isImport = await Get.defaultDialog<bool>(
      title: "确定要导出当前数据?",
      middleText: "",
      onCancel: () => Get.back(result: false),
      onConfirm: () => Get.back(result: true),
    );
    if (!JSON(isImport).boolValue) return;
    String cosPath = "code_analyzer_realm_db";
    Realm _realm = Get.find<RealmController>().realm;
    String filePath = _realm.config.path;
    await TencentCos.instance.download(cosPath, filePath);
    _realm.close();
    Get.find<RealmController>().initRealm();
    books.value = realm.all<Book>().toList();
  }

  void initCos() {
    Get.dialog(const Dialog(child: InitCosView()));
  }

  Realm get realm => Get.find<RealmController>().realm;
}
