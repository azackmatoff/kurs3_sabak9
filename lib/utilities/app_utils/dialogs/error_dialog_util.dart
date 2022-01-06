import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/widgets/dialogs/error_dialog.dart';

class ErrorDialogUtil {
  static void showErrorDialog(BuildContext context, String error) => showDialog(
        context: context,
        builder: (_) => ErrorDialogWidget(
          error: error,
        ),
      );
}
