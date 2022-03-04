import 'event.dart';
import 'database_helper.dart';

class EventManager {
  final dbHelper = DatabaseHelper.instance;

  EventManager._privateConstructor();

  static final EventManager instance = EventManager._privateConstructor();

  Future<void>  insert(newEvent) async {
    var event = Event(
      name: newEvent,
      event: '日常任務',
    );
    dbHelper.insert(event.toMap());
    print('------insert執行結束------');
  }

  Future<List<Map<String, dynamic>>> query()async{
    final rows = await dbHelper.queryAllRow();
    return rows;
  }

  Future<void> delete(id) async{
    dbHelper.delete(id!);
    print('---delete 執行結束---');
  }
}
