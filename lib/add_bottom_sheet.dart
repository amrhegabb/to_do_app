import 'package:flutter/material.dart';
import 'package:to_do_app/database/my_database.dart';
import 'package:to_do_app/database/task.dart';
import 'package:to_do_app/dialogUI.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskdetailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Add new Task",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TextFormField(
                controller: taskTitleController,
                decoration: const InputDecoration(
                  hintText: "Enter Your Task",
                ),
                validator: (currentText) {
                  if (currentText == null || currentText.trim().isEmpty) {
                    return 'please enter title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: taskdetailController,
                maxLines: 3,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'please enter details';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Enter Descrebtion",
                ),
              ),
              Text(
                "Select Time",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      showDatePickerDialog();
                    },
                    child: Text(
                      "'${selectedDate.year}/${selectedDate.month}/${selectedDate.day}'",
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor)))),
                    onPressed: () {
                      addTask();
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 18),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showDatePickerDialog() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (dateTime != null) {
      selectedDate = dateTime;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState!.validate()) {
      String title = taskTitleController.text;
      var desc = taskdetailController.text;
      Task task = Task(
          title: title,
          dateTime: selectedDate,
          isDone: false,
          description: desc);
      MyDatabase.insertTask(task).then((value) {
        showMessage(
          context,
          "Task Added Sucsuufuly",
          positiveactionName: "ok",
          positiveAction: () {
            Navigator.pop(context);
          },
        );
      }).onError((error, stackTrace) {
        hideLoding(context);
        showMessage(context, "Something went wrong try again");
      }).timeout(const Duration(seconds: 5), onTimeout: () {
        showMessage(context, "Task saved  localy ");
      });
    }
  }
}
