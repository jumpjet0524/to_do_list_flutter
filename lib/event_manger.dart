import 'event.dart';
import 'database_helper.dart';

class EventManager {
  final dbHepler = DatabaseHelper.instance;

  EventManager._privateConstructor();

  static final EventManager instance = EventManager._privateConstructor();

  void insert() async {
    var event = Event(
      name: '打神魔',
      event: '日常任務',
    );
    dbHepler.insert(event.toMap());
    print('------insert執行結束------');
  }

  Future<List<Map<String, dynamic>>> query()async{
    final list = [];
    final rows = await dbHepler.queryAllRow();
    print('查詢結果');
    rows.forEach((i) {
      list.add(i['name']);
    });

    return rows;
  }

  void delete()async{
    final id = await dbHepler.queryRowCount();
    dbHepler.delete(id!);
    print('---delete 執行結束---');
  }
}
