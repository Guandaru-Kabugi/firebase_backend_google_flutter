import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProfileImageDB {
  static const String _tableName = 'profile_image';
  static const String _columnPath = 'image_path';

  Database? _db;

  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final pathToDB = join(dbPath, 'profile_image.db');

    _db = await openDatabase(
      pathToDB,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnPath TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveImagePath(String path) async {
    await _db!.delete(_tableName); // only one image at a time
    await _db!.insert(_tableName, {_columnPath: path});
  }

  Future<String?> getImagePath() async {
    final result = await _db!.query(_tableName, limit: 1);
    if (result.isNotEmpty) {
      return result.first[_columnPath] as String;
    }
    return null;
  }
}
