import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const MaterialColor primarySwatch = MaterialColor(
  0xff17171A,
  <int, Color>{
    50: Color(0xff17171A),
    100: Color(0xff17171A),
    200: Color(0xff17171A),
    300: Color(0xff17171A),
    400: Color(0xff17171A),
    500: Color(0xff17171A),
    600: Color(0xff17171A),
    700: Color(0xff17171A),
    800: Color(0xff17171A),
    900: Color(0xff17171A),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HydroIQ ToDo',
      theme: ThemeData(
        fontFamily: 'JosefinSans',
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'HydroIQ ToDo'),
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

  final List<ListItem> todoTaskList = new List();
  final List<ListItem> completedTaskList = new List();
  int _index = 0;

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
                color: Color(0xff222228),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24),
                  Text(
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
                          contentPadding: EdgeInsets.only(
                              top: 24.0, bottom: 16.0, left: 16.0, right: 16.0),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 18.0),
                          labelText: 'Add your task here',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
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
                        color: Color(0xff3E6AD5),
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
                          _addTodoItem();
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
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    setState(() {
      todoTaskList.add(TodoItem(todoItemController.text));
    });
  }

  // Much like _addTodoItem, this modifies the array of todo strings and
// notifies the app that the state has changed by using setState
  void _removeTodoItem(int index) {
    setState(() {
      completedTaskList.add(todoTaskList[index]);
      todoTaskList.removeAt(index);
    });
  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${todoTaskList[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Monday 28th")),
      ),
      body: Container(
        color: Color(0xff17171A),
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
                        color: Color(0xff222228),
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
                    String title = "ToDo Tasks";
                    List taskList = todoTaskList;

                    if (i == 1) {
                      title = "Completed Tasks";
                      taskList = completedTaskList;
                    }

                    return Transform.scale(
                      scale: i == _index ? 1 : 0.95,
                      child: Card(
                        color: Color(0xff333338),
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
                                            _promptRemoveTodoItem(index));
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
        backgroundColor: Color(0xff3E6AD5),
        onPressed: _displayDialog,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTask(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTask(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Text(
        heading,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

/// A ListItem that contains data to display a message.
class TodoItem implements ListItem {
  final String task;

  TodoItem(this.task);

  Widget buildTask(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Color(0xff222228),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            task,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
