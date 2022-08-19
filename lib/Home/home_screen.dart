import 'package:flutter/material.dart';
import 'package:to_do_app/Home/settings/settings.dart';
import 'package:to_do_app/Home/taskeslist/tasks_list-tab.dart';
import 'package:to_do_app/add_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homescreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("To Do List"),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: ""),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 4)),
        onPressed: () {
          showAddTodoBottomSheet();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  var tabs = [
    const TaskesListTab(),
    const Settings(),
  ];

  void showAddTodoBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: ((context) => const AddBottomSheet()));
  }
}
