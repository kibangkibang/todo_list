import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/providers/todo_firestore.dart';
import '../models/todo.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late List<Todo> todos;
  TodoFirebase todoFirebase = TodoFirebase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      todoFirebase.initDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: todoFirebase.todoStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          }else{
            todos = todoFirebase.getTodos(snapshot);
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
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String title = '';
                  String description = '';
                  return AlertDialog(
                    title: Text('할 일 추가하기'),
                    content: Container(
                      height: 200,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              title = value;
                            },
                            decoration: InputDecoration(labelText: '제목'),
                          ),
                          TextField(
                            onChanged: (value) {
                              description = value;
                            },
                            decoration: InputDecoration(labelText: '설명'),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            todoFirebase.todosReference.add(
                                  Todo(title: title, description: description).toMap()).then((value) {
                                    Navigator.of(context).pop();
                                  },);
                          },
                          child: Text('추가')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('취소'))
                    ],
                  );
                });
          },
          child: Center(
            child: Text(
              '+',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        body: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index].title),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: Text('할 일'),
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('제목' + todos[index].title),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('설명' + todos[index].description),
                                ),
                              ],
                            );
                          });
                    },
                    trailing: Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              child: Icon(Icons.edit),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String title = todos[index].title;
                                      String description =
                                          todos[index].description;
                                      return AlertDialog(
                                        title: Text('할 일 수정하기'),
                                        content: Container(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              TextField(
                                                onChanged: (value) {
                                                  title = value;
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                        todos[index].title),
                                              ),
                                              TextField(
                                                onChanged: (value) {
                                                  description = value;
                                                },
                                                decoration: InputDecoration(
                                                    hintText: todos[index]
                                                        .description),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Todo newTodo = Todo(title: title, description: description,reference:todos[index].reference);
                                                todoFirebase.updateTodo(newTodo).then((value){
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text('수정')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('취소'))
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text('할 일 삭제하기'),
                                    content: Container(child: Text('삭제하시겠습니까?')),
                                    actions: [
                                      TextButton(onPressed: () async{
                                        todoFirebase.deleteTodo(todos[index]).then((value){
                                          Navigator.of(context).pop();
                                        });
                                      }, child: Text('삭제')),
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child: Text('취소'))
                                    ],
                                  );
                                });
                              },
                              child: Icon(Icons.delete),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: todos.length));
          }
        });
  }
}
