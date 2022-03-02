import 'event.dart';
import 'database_helper.dart';

class EventManager {
  final dbHepler = DatabaseHelper.instance;

  EventManager._privateConstructor();

  static final EventManager instance = EventManager._privateConstructor();

  Future<void>  insert() async {
    var event = Event(
      name: '打神魔',
      event: '日常任務',
    );
    dbHepler.insert(event.toMap());
    print('------insert執行結束------');
  }

  Future<List<Map<String, dynamic>>> query()async{
    final rows = await dbHepler.queryAllRow();
    return rows;
  }

  Future<void> delete(id) async{
    dbHepler.delete(id!);
    print('---delete 執行結束---');
  }
}
