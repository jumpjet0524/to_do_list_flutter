import 'dart:convert';

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
      home: const MyHomePage(title: 'To Do List'),
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
  late String newEvent;
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
                        setState(() {});
                      });
                    },
                    child: ListTile(title: Text('${allData[index]['name']}')),
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
              title: const Text('NEW'),
              content: TextField(
                onChanged: (value) {
                  newEvent = value;
                },
                decoration: const InputDecoration(hintText: "insert new event"),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if(newEvent.isNotEmpty){
                      EventManager.instance.insert(newEvent).then((value) {

                        setState(() {});
                      });
                    }
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
