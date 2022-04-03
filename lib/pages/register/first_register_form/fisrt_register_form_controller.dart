import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstRegisterFormController extends GetxController {
  Future selectDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null) {
      dateController.text = picked
          .toString()
          .split(" ")[0]
          .split("-")
          .reversed
          .join("/")
          .toString();
    }
  }

  TextEditingController dateController = TextEditingController();
}
