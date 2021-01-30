import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:intl/intl.dart';

// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTask(BuildContext context);
}

// A ListItem that contains data to display a message.
class TodoItem implements ListItem {
  final String task;
  final DateTime time;

  TodoItem(this.task, this.time);

  String get taskItem => task;
  DateTime get timeItem => time;

  Widget buildTask(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Color(colorBackground),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  task,
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
              Text(
                DateFormat.yMEd().add_jms().format(time),
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ],
          ),
        ),
      );
}
