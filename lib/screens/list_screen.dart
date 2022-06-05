import 'package:flutter/material.dart';

import '../models/todo.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('할 일 목록 앱'),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.book), Text("뉴스")],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
          child: Center(
            child: Text(
              '+',
              style: TextStyle(fontSize: 25),
            ),
        ),
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),)
      :
      ListView.separated(itemBuilder: (context,index){
        return ListTile(
          title: Text(todos[index].title),
          onTap: (){},
          trailing: Container(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    child: Icon(Icons.edit),
                    onTap: (){},
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: (){},
                    child: Icon(Icons.delete),
                  ),
                )
              ],
            ),
          ),
        );
      }
      , separatorBuilder: (context,index){
        return Divider();
      }
      , itemCount: todos.length)
    );
  }
}
