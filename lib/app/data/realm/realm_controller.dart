import 'package:codeword_analysis/app/data/realm/book.dart';
import 'package:get/get.dart' hide Progress;
import 'package:realm/realm.dart';

class RealmController extends GetxController {
  late Realm realm;

  RealmController() {
    realm = Realm(Configuration.local(
      [
        Book.schema,
        Chapter.schema,
        EditHistory.schema,
        EditDayDescription.schema
      ],
      schemaVersion: 4,
      migrationCallback: (migration, oldSchemaVersion) {},
    ));
  }

  void initRealm() {
    realm = Realm(Configuration.local(
      [
        Book.schema,
        Chapter.schema,
        EditHistory.schema,
        EditDayDescription.schema
      ],
      schemaVersion: 4,
      migrationCallback: (migration, oldSchemaVersion) {},
    ));
  }
}
