import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

toastMessage(
    {required BuildContext context,
    required String description,
    required ToastificationType type}) {
  return toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flat,
    title: const Text('POS'),
    description: Text(description),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 3),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: lowModeShadow,
  );
}
