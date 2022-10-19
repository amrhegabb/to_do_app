// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/database/my_database.dart';
import 'package:to_do_app/database/task.dart';
import 'package:to_do_app/dialogUI.dart';
import 'package:to_do_app/my_theme.dart';

// ignore: must_be_immutable
class TaskWidgit extends StatelessWidget {
  Task task;
  TaskWidgit({
    Key? key,
    required this.task,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              padding: const EdgeInsets.all(10),
              icon: Icons.delete,
              backgroundColor: MyTheme.red,
              label: 'delete',
              onPressed: (_) {
                MyDatabase.deleteTask(task).then((value) {
                  showMessage(
                    context,
                    "Data Deleted Sucssufuly",
                  );
                }).onError((error, stackTrace) {
                  showMessage(context, "message");
                }).timeout(
                  const Duration(seconds: 5),
                  onTimeout: () {
                    showMessage(context, "Data deleted locally");
                  },
                );
              },
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                        Text(
                          task.description ?? "",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: const ImageIcon(
                  AssetImage("assets/images/Check_IC.png"),
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
