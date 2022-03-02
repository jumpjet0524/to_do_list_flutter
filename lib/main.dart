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
    List<int> items = List<int>.generate(a.length, (int index) => index);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
              color: Colors.green,
            ),
            key: UniqueKey(),
            onDismissed: (direction) {
              EventManager.instance.delete(a[index]['id']).then((val) {
                setState(() {
                  table.then((value) {
                    setState(() {
                      a = value;
                      print(a);
                    });
                  });
                });
              });
            },
            child: ListTile(title: Text('${a[index]['name']}')),
          );
        },
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('AlertDialog Title'),
              content: const Text('AlertDialog description'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    EventManager.instance.insert().then((value) {
                      table.then((value) {
                        setState(() {
                          a = value;
                        });
                      });
                    });

                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
