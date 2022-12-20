import 'package:flutter/material.dart';
import 'package:colab/services/responsive.dart';

void errorAlertMessage(String errorMessage, BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      insetPadding: Responsive.isDesktop(context)
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3,
            )
          : const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      title: Center(
          child: Text(
        errorMessage,
      )),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Center(child: Text('OK')),
        ),
      ],
    ),
  );
}