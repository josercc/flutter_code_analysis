import 'package:get/get.dart';

import '../modules/chapter/bindings/chapter_binding.dart';
import '../modules/chapter/views/chapter_view.dart';
import '../modules/chapter_detail/bindings/chapter_detail_binding.dart';
import '../modules/chapter_detail/views/chapter_detail_view.dart';
import '../modules/edit_history/bindings/edit_history_binding.dart';
import '../modules/edit_history/views/edit_history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHAPTER,
      page: () => const ChapterView(),
      binding: ChapterBinding(),
    ),
    GetPage(
      name: _Paths.CHAPTER_DETAIL,
      page: () => const ChapterDetailView(),
      binding: ChapterDetailBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_HISTORY,
      page: () => const EditHistoryView(),
      binding: EditHistoryBinding(),
    ),
  ];
}
