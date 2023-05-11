// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Book extends _Book with RealmEntity, RealmObjectBase, RealmObject {
  Book(
    Uuid uuid,
    String bookName,
    int bookWordCount,
  ) {
    RealmObjectBase.set(this, 'uuid', uuid);
    RealmObjectBase.set(this, 'bookName', bookName);
    RealmObjectBase.set(this, 'bookWordCount', bookWordCount);
  }

  Book._();

  @override
  Uuid get uuid => RealmObjectBase.get<Uuid>(this, 'uuid') as Uuid;
  @override
  set uuid(Uuid value) => RealmObjectBase.set(this, 'uuid', value);

  @override
  String get bookName =>
      RealmObjectBase.get<String>(this, 'bookName') as String;
  @override
  set bookName(String value) => RealmObjectBase.set(this, 'bookName', value);

  @override
  int get bookWordCount =>
      RealmObjectBase.get<int>(this, 'bookWordCount') as int;
  @override
  set bookWordCount(int value) =>
      RealmObjectBase.set(this, 'bookWordCount', value);

  @override
  Stream<RealmObjectChanges<Book>> get changes =>
      RealmObjectBase.getChanges<Book>(this);

  @override
  Book freeze() => RealmObjectBase.freezeObject<Book>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Book._);
    return const SchemaObject(ObjectType.realmObject, Book, 'Book', [
      SchemaProperty('uuid', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('bookName', RealmPropertyType.string),
      SchemaProperty('bookWordCount', RealmPropertyType.int),
    ]);
  }
}

class Chapter extends _Chapter with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Chapter(
    Uuid uuid,
    int chapterIndex,
    int chapterWordCount,
    int timeInterval, {
    bool isPublished = false,
    Book? book,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Chapter>({
        'isPublished': false,
      });
    }
    RealmObjectBase.set(this, 'uuid', uuid);
    RealmObjectBase.set(this, 'chapterIndex', chapterIndex);
    RealmObjectBase.set(this, 'chapterWordCount', chapterWordCount);
    RealmObjectBase.set(this, 'isPublished', isPublished);
    RealmObjectBase.set(this, 'timeInterval', timeInterval);
    RealmObjectBase.set(this, 'book', book);
  }

  Chapter._();

  @override
  Uuid get uuid => RealmObjectBase.get<Uuid>(this, 'uuid') as Uuid;
  @override
  set uuid(Uuid value) => RealmObjectBase.set(this, 'uuid', value);

  @override
  int get chapterIndex => RealmObjectBase.get<int>(this, 'chapterIndex') as int;
  @override
  set chapterIndex(int value) =>
      RealmObjectBase.set(this, 'chapterIndex', value);

  @override
  int get chapterWordCount =>
      RealmObjectBase.get<int>(this, 'chapterWordCount') as int;
  @override
  set chapterWordCount(int value) =>
      RealmObjectBase.set(this, 'chapterWordCount', value);

  @override
  bool get isPublished =>
      RealmObjectBase.get<bool>(this, 'isPublished') as bool;
  @override
  set isPublished(bool value) =>
      RealmObjectBase.set(this, 'isPublished', value);

  @override
  int get timeInterval => RealmObjectBase.get<int>(this, 'timeInterval') as int;
  @override
  set timeInterval(int value) =>
      RealmObjectBase.set(this, 'timeInterval', value);

  @override
  Book? get book => RealmObjectBase.get<Book>(this, 'book') as Book?;
  @override
  set book(covariant Book? value) => RealmObjectBase.set(this, 'book', value);

  @override
  Stream<RealmObjectChanges<Chapter>> get changes =>
      RealmObjectBase.getChanges<Chapter>(this);

  @override
  Chapter freeze() => RealmObjectBase.freezeObject<Chapter>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Chapter._);
    return const SchemaObject(ObjectType.realmObject, Chapter, 'Chapter', [
      SchemaProperty('uuid', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('chapterIndex', RealmPropertyType.int),
      SchemaProperty('chapterWordCount', RealmPropertyType.int),
      SchemaProperty('isPublished', RealmPropertyType.bool),
      SchemaProperty('timeInterval', RealmPropertyType.int),
      SchemaProperty('book', RealmPropertyType.object,
          optional: true, linkTarget: 'Book'),
    ]);
  }
}

class EditHistory extends _EditHistory
    with RealmEntity, RealmObjectBase, RealmObject {
  EditHistory(
    Uuid uuid,
    int timeInterval,
    int wordCount, {
    Chapter? chapter,
  }) {
    RealmObjectBase.set(this, 'uuid', uuid);
    RealmObjectBase.set(this, 'timeInterval', timeInterval);
    RealmObjectBase.set(this, 'chapter', chapter);
    RealmObjectBase.set(this, 'wordCount', wordCount);
  }

  EditHistory._();

  @override
  Uuid get uuid => RealmObjectBase.get<Uuid>(this, 'uuid') as Uuid;
  @override
  set uuid(Uuid value) => RealmObjectBase.set(this, 'uuid', value);

  @override
  int get timeInterval => RealmObjectBase.get<int>(this, 'timeInterval') as int;
  @override
  set timeInterval(int value) =>
      RealmObjectBase.set(this, 'timeInterval', value);

  @override
  Chapter? get chapter =>
      RealmObjectBase.get<Chapter>(this, 'chapter') as Chapter?;
  @override
  set chapter(covariant Chapter? value) =>
      RealmObjectBase.set(this, 'chapter', value);

  @override
  int get wordCount => RealmObjectBase.get<int>(this, 'wordCount') as int;
  @override
  set wordCount(int value) => RealmObjectBase.set(this, 'wordCount', value);

  @override
  Stream<RealmObjectChanges<EditHistory>> get changes =>
      RealmObjectBase.getChanges<EditHistory>(this);

  @override
  EditHistory freeze() => RealmObjectBase.freezeObject<EditHistory>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(EditHistory._);
    return const SchemaObject(
        ObjectType.realmObject, EditHistory, 'EditHistory', [
      SchemaProperty('uuid', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('timeInterval', RealmPropertyType.int),
      SchemaProperty('chapter', RealmPropertyType.object,
          optional: true, linkTarget: 'Chapter'),
      SchemaProperty('wordCount', RealmPropertyType.int),
    ]);
  }
}

class EditDayDescription extends _EditDayDescription
    with RealmEntity, RealmObjectBase, RealmObject {
  EditDayDescription(
    Uuid uuid,
    int noPublishCount,
    int totalCount,
    String date, {
    Book? book,
  }) {
    RealmObjectBase.set(this, 'uuid', uuid);
    RealmObjectBase.set(this, 'noPublishCount', noPublishCount);
    RealmObjectBase.set(this, 'totalCount', totalCount);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'book', book);
  }

  EditDayDescription._();

  @override
  Uuid get uuid => RealmObjectBase.get<Uuid>(this, 'uuid') as Uuid;
  @override
  set uuid(Uuid value) => RealmObjectBase.set(this, 'uuid', value);

  @override
  int get noPublishCount =>
      RealmObjectBase.get<int>(this, 'noPublishCount') as int;
  @override
  set noPublishCount(int value) =>
      RealmObjectBase.set(this, 'noPublishCount', value);

  @override
  int get totalCount => RealmObjectBase.get<int>(this, 'totalCount') as int;
  @override
  set totalCount(int value) => RealmObjectBase.set(this, 'totalCount', value);

  @override
  String get date => RealmObjectBase.get<String>(this, 'date') as String;
  @override
  set date(String value) => RealmObjectBase.set(this, 'date', value);

  @override
  Book? get book => RealmObjectBase.get<Book>(this, 'book') as Book?;
  @override
  set book(covariant Book? value) => RealmObjectBase.set(this, 'book', value);

  @override
  Stream<RealmObjectChanges<EditDayDescription>> get changes =>
      RealmObjectBase.getChanges<EditDayDescription>(this);

  @override
  EditDayDescription freeze() =>
      RealmObjectBase.freezeObject<EditDayDescription>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(EditDayDescription._);
    return const SchemaObject(
        ObjectType.realmObject, EditDayDescription, 'EditDayDescription', [
      SchemaProperty('uuid', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('noPublishCount', RealmPropertyType.int),
      SchemaProperty('totalCount', RealmPropertyType.int),
      SchemaProperty('date', RealmPropertyType.string),
      SchemaProperty('book', RealmPropertyType.object,
          optional: true, linkTarget: 'Book'),
    ]);
  }
}
