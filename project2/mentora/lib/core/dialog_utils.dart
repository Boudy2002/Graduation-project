import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils{

  static showLoadingDialog({required BuildContext context}){
    showDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
        content: Row(
          children: [
            Text("loading...."),
            Spacer(),
            CircularProgressIndicator()
          ],
        ),
      );
    });
  }

  static hideDialog(BuildContext context){
    Navigator.pop(context);
  }

  static void showMessageDialog(
      BuildContext context, {
        required String message,
        String? title,
        String? posActionTitle,
        String? negActionTitle,
        VoidCallback? posAction,
        VoidCallback? negAction,
      }) {
    List<Widget> actions = [];

    if (posActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionTitle,  style: Theme.of(context).textTheme.headlineSmall,),
        ),
      );
    }
    if (negActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            negAction?.call();
          },
          child: Text(negActionTitle, style: Theme.of(context).textTheme.headlineSmall,),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(message),
          title: title != null ? Text(title) : null,
          actions: actions,
        );
      },
    );
  }
}