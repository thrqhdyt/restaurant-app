import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Setting';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Setting'),
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              child: ListTile(
                title: const Text("Daily Reminder"),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyNotificationActive,
                      onChanged: (value) async {
                        scheduled.scheduleNotificationRestaurant(value);
                        provider.enableDailyNotification(value);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
