import 'package:sqflite/sqflite.dart';
import 'package:untitled2/models/task.dart';

class DbHelper {
  static Database? _db;
  static final int _veersion = 1;
  static final String _tableName = 'tasks';

  static Future<void> initDb() async
  {
    if (_db != null) {

      return ;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db =
      await openDatabase(_path, version: _veersion, onCreate: (db, version) {
        print('creating a new one');
        return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING, note TEXT,date STRING, "
                "startTime STRING,endTime STRING, "
                "remind INTEGER ,repeat STRING, "
                "color INTEGER, "
                "isCompleted INTEGER)",
        );
      },
      );
    }catch(e)
    {
      print(e.toString());
    }
  }
  static Future<int> insert(Task? task)async
  {
    print('insert function called');
    return await _db?.insert(_tableName, task!.toMap())??1;
  }
   static Future<List<Map<String,dynamic>>>query()async
  {
    return await _db!.query(_tableName);
  }
  static delete(Task task)async
  {
    await _db!.delete(_tableName,where: 'id=?' ,whereArgs: [task.id]);

  }
  static update(int id)async
  {
   return await _db!.rawUpdate('''
    Update tasks
    Set isCompleted =?
    WHERE id =?
    ''',[1,id]);
  }
  static updateUnMarked(int id)async
  {
    return await _db!.rawUpdate('''
    Update tasks
    Set isCompleted =?
    WHERE id =?
    ''',[0,id]);
  }
}