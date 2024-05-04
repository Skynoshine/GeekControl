import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DatabaseController {
  final Uri _dbUri = Uri.parse(dotenv.env['MONGO_URI']!);
  final String _collection = 'cache-test';
  late Db _db;

  Future<Db> _connect() async {
    _db = await Db.create(_dbUri.toString());
    try {
      await _db.open();
    } catch (e) {
      throw Exception(e);
    }
    return _db;
  }

  Future<void> _close() async {
    if (_db.isConnected) {
      try {
        await _db.close();
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future<void> insert(Map<String, dynamic> data) async {
    await _connect();
    await _db.collection(_collection).insert(data);
    await _close();
  }

  Future<void> insertList(List<Map<String, dynamic>> dataList) async {
    try {
      await _connect();
      await _db.collection(_collection).insertAll(dataList);
    } finally {
      await _close();
    }
  }

  Future<List<Map<String, dynamic>>> get(int quantity) async {
    try {
      await _connect();
      final collection = _db.collection(_collection);

      final response = await collection
          .find(where.sortBy('date', descending: true).limit(quantity))
          .toList();
      return response;
    } catch (e) {
      throw Exception('Error fetching data from MongoDB: $e');
    } finally {
      await _close();
    }
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    try {
      await _connect();
      final collection = _db.collection(_collection);

      final response = await collection
          .find(where.sortBy('date', descending: true))
          .toList();
      return response;
    } catch (e) {
      throw Exception('Error fetching all data from MongoDB: $e');
    } finally {
      await _close();
    }
  }

  Future<bool> checkDoubleContent({
    required String find,
    required Object findObject,
  }) async {
    await _connect();
    var collection = _db.collection(_collection);
    var result = await collection.findOne({find: findObject});
    await _close();
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getSpecific(
      {required String post, required String param}) async {
    await _connect();
    final collection = _db.collection(_collection);
    final table = where.eq(param, post);

    final response = await collection.findOne(table);

    await _close();
    return response;
  }
}
