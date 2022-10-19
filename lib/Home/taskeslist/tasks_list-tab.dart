import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Home/taskeslist/task_widgit.dart';
import 'package:to_do_app/database/my_database.dart';
import 'package:to_do_app/database/task.dart';
import 'package:to_do_app/dateUtils.dart';

class TaskesListTab extends StatefulWidget {
  const TaskesListTab({Key? key}) : super(key: key);

  @override
  State<TaskesListTab> createState() => _TaskesListTabState();
}

class _TaskesListTabState extends State<TaskesListTab> {
  DateTime selecteddate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          leftMargin: 20,
          monthColor: Colors.black,
          dayColor: Colors.black,
          activeBackgroundDayColor: Colors.white,
          activeDayColor: Theme.of(context).primaryColor,
          dayNameColor: Theme.of(context).primaryColor,
          dotsColor: Theme.of(context).primaryColor,
          initialDate: selecteddate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selecteddate = date;
            setState(() {});
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Task>>(
            stream: MyDatabase.listenforrealtimeUpdates(dateOnly(selecteddate)),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(
                      "error Loading data",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Try Again",
                          style: Theme.of(context).textTheme.titleMedium,
                        ))
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                var data = snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskWidgit(
                      task: data[index],
                    );
                  },
                  itemCount: data.length,
                );
              }
            }),
          ),
        )
      ],
    );
  }
}
