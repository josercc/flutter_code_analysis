import 'package:realm/realm.dart';
part 'book.g.dart';

// 书籍
@RealmModel()
class _Book {
  @PrimaryKey()
  late Uuid uuid;
  // 书名
  late String bookName;
  // 书籍预计的字数
  late int bookWordCount;
}

// 章节
@RealmModel()
class _Chapter {
  @PrimaryKey()
  late Uuid uuid;
  // 章节索引
  late int chapterIndex;
  // 章节字数
  late int chapterWordCount;
  // 是否已发布
  bool isPublished = false;
  // 发布时间
  late int timeInterval;

  // 对应书籍
  _Book? book;
}

/// 修改的历史记录
@RealmModel()
class _EditHistory {
  @PrimaryKey()
  late Uuid uuid;
  // 修改时间
  late int timeInterval;
  // 修改章节
  _Chapter? chapter;
  // 修改字数
  late int wordCount;
}

@RealmModel()
class _EditDayDescription {
  @PrimaryKey()
  late Uuid uuid;
  // 存稿
  late int noPublishCount;
  // 总字数
  late int totalCount;

  late String date;

  _Book? book;
}
