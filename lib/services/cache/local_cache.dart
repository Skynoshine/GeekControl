import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

// class LocalCache {
//   get() async {
//     final appDocDir = await getApplicationDocumentsDirectory();
//     await appDocDir.create(recursive: true);
//     final path = '${appDocDir.path}/test.db';

//     final db = await databaseFactoryIo.openDatabase(path);

//     var store = StoreRef.main();
//     await store.record('title').put(db, 'FUNCIONA PELO AMOR DE DEUS!!!');
//     final t = await store.record('title').get(db);
//     Logger().i(t);
//   }
// }
