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
  List<dynamic> allData = [];
  // Future<List<Map<String, dynamic>>> table = EventManager.instance.query();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: EventManager.instance.query(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              allData = snapshot.data as List<dynamic> ;
              return ListView.builder(
                itemCount: allData.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.green,
                    ),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      EventManager.instance.delete(allData[index]['id']).then((val) {
                        print(allData);
                        setState(() {});
                      });
                    },
                    child: ListTile(title: Text('${allData[index]['id']}')),
                  );
                },
              );
            } else {
              print('Awaiting result...');
              return Container();
            }
          }),
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
                      setState(() {});
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
