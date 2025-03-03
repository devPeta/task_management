import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ///Get The Box
  final _myBox = Hive.box("My_Box");

  ///Text Controller 
  final _textController = TextEditingController();

  ///List of Tasks
  List todos = [];

  ///Init State
  @override
  void initState(){
    todos = _myBox.get("TODO_LIST") ?? [];
    super.initState();
  }
  
  ///Open A New Task Box Method
  void openNewTodo(){
    showDialog(
      context:context,
      builder:(context)=> AlertDialog(
        title:Text("Add Task"),
        content: TextField(
          controller: _textController,
        ),
        actions: [
          ///Cancel Button
          TextButton(
            onPressed:(){
              Navigator.pop(context);
              _textController.clear();
            },
            child: Text('Cancel')
          ),

          ///Add Button
               TextButton(
            onPressed:(){},
            child: Text('Add')
          ),
        ],
      ),
    );
  }
  
  ///Add New Task
  void addTodo(){
    String todo = _textController.text;
    setState(() {
      todos.add(todo);
      _textController.clear();
    });
  }
  
  ///Save To Database
  void saveToDatabase(){
    _myBox.put("TODO_LIST", todos);
  }

  ///Delete
  void deleteTodo(int index){
    setState(() {
      todos.removeAt(index);
    });
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Add Task 
      floatingActionButton: FloatingActionButton(onPressed: openNewTodo,
      child: Icon(Icons.add),
      ),

      ///Body
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index){
          //get each todo
          final todo = todos[index];

          return ListTile(
            title: Text(todo),
            trailing: IconButton(onPressed: ()=> deleteTodo(index), 
            icon: Icon(Icons.delete)
            ),
          );
        },
        ),
    );
  }
}