import 'package:flutter/material.dart';
import 'package:flutter_template/src/bootstrap.dart';
import 'package:flutter_template/src/logic/logics.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget with GetItMixin {
  SettingsView({super.key});

  Brightness? _brightness() => watchX((SettingsLogic s) => s.currentBrightness);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: DropdownButton<Brightness>(
          // Read the selected themeMode from the controller
          value: _brightness(),
          // Call the updateThemeMode method any time the user selects a theme.
          onChanged: (Brightness? value) =>
              settingsLogic.currentBrightness.value = value,
          items: [
            DropdownMenuItem(
              child: Text($strings.themeModeSystem),
            ),
            DropdownMenuItem(
              value: Brightness.light,
              child: Text($strings.themeModeLight),
            ),
            DropdownMenuItem(
              value: Brightness.dark,
              child: Text($strings.themeModeDark),
            ),
          ],
        ),
      ),
    );
  }
}
