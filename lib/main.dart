import 'package:flutter/material.dart';
import 'constants.dart';
import 'task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        fontFamily: appFont,
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController todoItemController = TextEditingController();

  final List<TodoItem> todoTaskList = new List();
  final List<TodoItem> completedTaskList = new List();
  int _index = 0;
  int editItemIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Monday 28th")),
      ),
      body: Container(
        color: Color(colorBackground),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(colorBackgroundLight),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          'Weather information here',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: 2,
                  controller: PageController(viewportFraction: 0.85),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    String title = tasksToDo;
                    List taskList = todoTaskList;

                    if (i == 1) {
                      title = tasksCompleted;
                      taskList = completedTaskList;
                    }

                    return Transform.scale(
                      scale: i == _index ? 1 : 0.95,
                      child: Card(
                        color: Color(colorBackgroundLight),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0, left: 32.0, bottom: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                  // Let the ListView know how many items it needs to build.
                                  itemCount: taskList.length,
                                  // Provide a builder function. This is where the magic happens.
                                  // Convert each item into a widget based on the type of item it is.
                                  itemBuilder: (context, index) {
                                    final item = taskList[index];

                                    return ListTile(
                                        title: item.buildTask(context),
                                        onTap: () =>
                                            _promptRemoveTodoItem(index, i));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(colorAccent),
        onPressed: _displayDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  _displayDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Color(colorBackgroundLight),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24),
                  editItemIndex > -1
                      ? Text(
                          "Edit Task",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : Text(
                          "New Task",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: todoItemController,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        maxLines: 1,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Color(colorBackground),
                          filled: true,
                          contentPadding: EdgeInsets.only(
                              top: 24.0, bottom: 16.0, left: 16.0, right: 16.0),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 18.0),
                          labelText: 'Add your task here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Add your task here';
                          }
                          return null;
                        },
                      )),
                  SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        color: Color(colorAccent),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, bottom: 14.0, left: 8.0, right: 8.0),
                          child: Text(
                            "Save Task",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          //Add data to list
                          if (editItemIndex > -1) {
                            _editTodoItem();
                          } else {
                            _addTodoItem();
                          }

                          todoItemController.clear();
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  // This will be called each time the + button is pressed
  void _addTodoItem() {
    // Putting our code inside "setState" tells the app that our state has changed, and it will automatically re-render the list
    setState(() {
      if (todoItemController.text.isNotEmpty) {
        todoTaskList.add(TodoItem(todoItemController.text));
      }
    });
  }

  // This modifies the array of todo strings and notifies the app that the state has changed by using setState
  void _showEditTodoItem(int index, int list) {
    editItemIndex = index;
    todoItemController.text = todoTaskList[index].taskItem;
    _displayDialog();
  }

  // This modifies the array of todo strings and notifies the app that the state has changed by using setState
  void _editTodoItem() {
    setState(() {
      todoTaskList[editItemIndex] = TodoItem(todoItemController.text);
      editItemIndex = -1;
    });
  }

  // This modifies the array of todo strings and notifies the app that the state has changed by using setState
  void _completeTodoItem(int index, int list) {
    setState(() {
      if (list == LIST_TODO) {
        completedTaskList.add(todoTaskList[index]);
        todoTaskList.removeAt(index);
      }
    });
  }

  // This modifies the array of todo strings and notifies the app that the state has changed by using setState
  void _removeTodoItem(int index, int list) {
    setState(() {
      if (list == LIST_TODO) {
        todoTaskList.removeAt(index);
      } else {
        completedTaskList.removeAt(index);
      }
    });
  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index, int list) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title:
                  new Text('Mark "${todoTaskList[index].taskItem}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('Delete'),
                    onPressed: () {
                      _removeTodoItem(index, list);
                      Navigator.of(context).pop();
                    }),
                list == LIST_TODO
                    ? new FlatButton(
                        child: new Text('Edit'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showEditTodoItem(index, list);
                        })
                    : Container(),
                list == LIST_TODO
                    ? new FlatButton(
                        child: new Text(
                          'Mark as Done',
                          style: TextStyle(
                            color: Color(colorAccent),
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          _completeTodoItem(index, list);
                          Navigator.of(context).pop();
                        })
                    : Container(),
              ]);
        });
  }
}
