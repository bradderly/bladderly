import 'package:bladderly/data/local/local_storage_client.dart';
import 'package:bladderly/data/local/object_box_client.dart';
import 'package:bladderly/data/local/objectbox.g.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

@module
abstract class LocalStorageModule {
  @lazySingleton
  @preResolve
  Future<Store> get store async {
    final docsDir = await getApplicationDocumentsDirectory();

    final store = await openStore(directory: p.join(docsDir.path, 'bladderly'));

    return store;
  }

  @lazySingleton
  LocalStorageClient getLocalStorageClient(Store store) {
    return ObjectBoxClient(store: store);
  }
}
