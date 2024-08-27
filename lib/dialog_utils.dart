import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String loadingLabel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 15,
                ),
                Text(loadingLabel)
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String content,
    String title = "",
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          posAction?.call();
        },
        child: Text(posActionName),
      )); // ElevatedButton
    }
    if (negActionName != null) {
      actions.add(ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          negAction?.call();
        },
        child: Text(negActionName),
      )); // ElevatedButton
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          title: Text(title),
          actions: actions,
        ); // AlertDialog
      },
    );
  }
}
