import 'package:to_do_list/models/todo.dart';

class TodoDefault{
  List<Todo> dummyTodos = [
    Todo(id:1, title: "플러터 공부 시작하기", description: "플러터를 알아가 봅시다."),
    Todo(id:2, title: "서점 가지", description: "중고서적 팔고 플러터 책 사기"),
    Todo(id:3, title: "카페에서 앱개발하기", description: "24시간 코딩만 하고 싶다."),
    Todo(id:4, title: "출근하기", description: "캐주얼 데이")
  ];

  List<Todo> getTodos(){
    return dummyTodos;
  }

  Todo getTodo(int id){
    return dummyTodos[id];
  }

  Todo addTodo(Todo todo){
    Todo newTodo = Todo(
        id: dummyTodos.length + 1,
        title: todo.title,
        description: todo.description);
    dummyTodos.add(newTodo);
    return newTodo;
  }

  void deleteTodo(int id){
    for(int i=0; i<dummyTodos.length;i++){
      if(dummyTodos[i].id == id){
        dummyTodos.removeAt(i);
      }
    }
  }
  void updateTodo(Todo todo){
    for(int i=0;i<dummyTodos.length;i++){
      if(dummyTodos[i].id == todo.id){
        dummyTodos[i] = todo;
      }
    }
  }
}