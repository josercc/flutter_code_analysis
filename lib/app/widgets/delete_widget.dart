import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeleteWidget extends StatelessWidget {
  final Key deleteKey;
  final Widget child;
  final String? title;
  final VoidCallback? onDismissed;
  const DeleteWidget({
    super.key,
    required this.deleteKey,
    required this.child,
    this.title,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: deleteKey,
      child: child,
      confirmDismiss: (direction) async {
        final isDelete = await Get.defaultDialog<bool>(
          title: title ?? "确定删除",
          middleText: "",
          textCancel: "取消删除",
          textConfirm: "确认删除",
          onCancel: () => Get.back(result: false),
          onConfirm: () => Get.back(result: true),
        );
        return JSON(isDelete).boolValue;
      },
      onDismissed: (direction) async {
        onDismissed?.call();
      },
    );
  }
}
