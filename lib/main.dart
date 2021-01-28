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
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'JosefinSans',
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final List<ListItem> items = List<ListItem>.generate(
    30,
    (i) => i % 6 == 0 ? HeadingItem("Heading $i") : MessageItem("Sender $i"),
  );

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    // Let the ListView know how many items it needs to build.
                    itemCount: items.length,
                    // Provide a builder function. This is where the magic happens.
                    // Convert each item into a widget based on the type of item it is.
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return ListTile(
                        title: item.buildTask(context),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
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
class MessageItem implements ListItem {
  final String task;

  MessageItem(this.task);

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
