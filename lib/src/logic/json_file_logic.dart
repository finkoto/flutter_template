import 'package:flutter/material.dart';
import 'package:flutter_template/src/logic/common/save_load_mixin.dart';

class JsonFileLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'change-me.dat';

  late final changeMe = ValueNotifier<bool>(false)..addListener(scheduleSave);

  @override
  void copyFromJson(Map<String, dynamic> value) {
    changeMe.value = value['change_me'] ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'change_me': changeMe.value,
    };
  }
}
