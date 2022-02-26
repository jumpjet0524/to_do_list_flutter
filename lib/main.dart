import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'event_manger.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var a = [];

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> table = EventManager.instance.query();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: List.generate(
          a.length,
          (i) => ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.flag),
            ),
            title: Text('${a[i]['name']}'),
            onTap: () {},
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              child: Text('查詢'),
              onPressed: () {
                table.then((value) {
                  setState(() {
                    a = value;
                    print(a);
                  });
                });
              },
            ),
            FloatingActionButton(
              child: Text('刪除'),
              onPressed: () {
                EventManager.instance.delete();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EventManager.instance.insert();
          table.then((value) {
            setState(() {
              a = value;
            });
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
