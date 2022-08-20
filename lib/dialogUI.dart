import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message,
    {String? positiveactionName,
    VoidCallback? positiveAction,
    String? NegativeactionName,
    VoidCallback? NegativeAction,
    bool iscancellabel = true}) {
  List<Widget> action = [];
  if (positiveactionName != null) {
    action.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (positiveAction != null) {
            positiveAction();
          }
        },
        child: Text(positiveactionName)));
  }
  if (NegativeactionName != null) {
    action.add(
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (NegativeAction != null) {
            NegativeAction();
          }
        },
        child: Text(
          NegativeactionName,
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          actions: action,
          content: Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      });
}

void ShowLoading(BuildContext context, String lodingMessage,
    {bool iscancellabel = true}) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircularProgressIndicator(),
              Text(lodingMessage),
            ],
          ),
        );
      },
      barrierDismissible: iscancellabel);
}

void hideLoding(BuildContext context) {
  Navigator.pop(context);
}
