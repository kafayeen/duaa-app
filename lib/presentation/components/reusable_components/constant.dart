import 'package:flutter/material.dart';

AppBar appBar({required BuildContext context, required String text}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    ),
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
          ))
    ],
  );
}
