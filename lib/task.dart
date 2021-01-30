import 'package:flutter/material.dart';
import 'constants.dart';

// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTask(BuildContext context);
}

// A ListItem that contains data to display a heading.
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

// A ListItem that contains data to display a message.
class TodoItem implements ListItem {
  final String task;

  TodoItem(this.task);

  Widget buildTask(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Color(colorBackground),
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
