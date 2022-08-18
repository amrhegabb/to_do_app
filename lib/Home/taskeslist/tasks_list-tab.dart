import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Home/taskeslist/task_widgit.dart';

class TaskesListTab extends StatelessWidget {
  const TaskesListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeBackgroundDayColor: Colors.white,
            activeDayColor: Theme.of(context).primaryColor,
            dayNameColor: Theme.of(context).primaryColor,
            dotsColor: Theme.of(context).primaryColor,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (datetime) {},
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return TaskWidgit();
              }),
              itemCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
