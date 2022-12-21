import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'posts.dart';

class MyAppPage extends StatefulWidget {
  final String title;
  const MyAppPage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}
const String url = 'https://jsonplaceholder.typicode.com/todos';
class _MyAppPageState extends State<MyAppPage> {
  List posts = <dynamic>[];

  @override
  void initState() {
    super.initState();
    getTODO();
  }

  getTODO() async{
    var feedback = await http.get(Uri.parse(url));
    if(feedback.statusCode == 200){
      setState(() {
        posts = convert.jsonDecode(feedback.body) as List<dynamic>;
      });
    }
  }

  delTodos(String id) async{
    var feedback = await http.delete(Uri.parse(url));
    if(feedback.statusCode == 200){
      setState(() {
        posts = POSTS.fromJson(convert.jsonDecode(feedback.body)) as List<dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.edit_note),
        backgroundColor: Colors.blue.shade700,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index){
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: const Card(
              color: Colors.grey,
              child: Icon(Icons.delete),
            ),
            onDismissed: (direction) => delTodos(posts[index]["id"].toString()),
            child: Card(
              color: Colors.blue.shade50,
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              elevation: 10,
              child: ListTile(
                title: Text(posts[index]["title"]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
