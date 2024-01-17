import 'dart:math';

import 'package:activity_tracker/data/activity_controller.dart';
import 'package:activity_tracker/data/models/activity.dart';
import 'package:activity_tracker/my_flat_button.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:activity_tracker/screen/main/widget/activity_chart.dart';
import 'package:activity_tracker/screen/main/widget/activity_info.dart';
import 'package:activity_tracker/screen/main/widget/your_activities.dart';
import 'package:activity_tracker/screen/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainSceen extends StatefulWidget {
  const MainSceen({super.key});

  @override
  State<MainSceen> createState() => _MainSceenState();
}

class _MainSceenState extends State<MainSceen> {
  late final ActivityController _activityController;
  @override
  void initState() {
    super.initState();
    _activityController = context.read<ActivityController>()
      ..addListener(_update);
  }

  void _update() => setState(() {});

  @override
  void dispose() {
    _activityController.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              ActivityInfo(controller: _activityController),
              const SizedBox(height: 8),
              MyFlatButton(
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: MyTheme.whiteColor,
                    builder: (context) {
                      return const YourActivities();
                    },
                  );
                },
                text: 'Your activities',
              ),
              const SizedBox(height: 16),
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              ActivityChart(activityController: _activityController),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 12),
          alignment: Alignment.topCenter,
          color: MyTheme.whiteColor,
          height: 80,
          child: Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
