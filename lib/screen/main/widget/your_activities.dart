import 'dart:math';

import 'package:activity_tracker/data/activity_controller.dart';
import 'package:activity_tracker/data/models/activity.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:activity_tracker/screen/create_activity/create_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class YourActivities extends StatefulWidget {
  const YourActivities({super.key});

  @override
  State<YourActivities> createState() => _YourActivitiesState();
}

class _YourActivitiesState extends State<YourActivities> {
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
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                height: 6,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Your activitites',
                      style: TextStyle(
                        color: MyTheme.blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateActivityScreen(),
                      ),
                    ),
                    child: Text(
                      'Create activity',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // children: [
                    //   Activity(
                    //     name: 'act',
                    //     colorCode: '111111',
                    //     iconPath: 'icons/activities/apple.svg',
                    //     time: Duration(hours: 4),
                    //     startDate: DateTime.now(),
                    //     endDate: DateTime.now(),
                    //   ),
                    //   Activity(
                    //     name: 'act',
                    //     colorCode: '526204',
                    //     iconPath: 'icons/activities/barbell.svg',
                    //     time: Duration(hours: 4),
                    //     startDate: DateTime.now(),
                    //     endDate: DateTime.now(),
                    //   ),
                    //   Activity(
                    //     name: 'act',
                    //     colorCode: '529620',
                    //     iconPath: 'icons/activities/moon.svg',
                    //     time: Duration(hours: 4),
                    //     startDate: DateTime.now(),
                    //     endDate: DateTime.now(),
                    //   ),
                    //   Activity(
                    //     name: 'act',
                    //     colorCode: '529620',
                    //     iconPath: 'icons/activities/moon.svg',
                    //     time: Duration(hours: 4),
                    //     startDate: DateTime.now(),
                    //     endDate: DateTime.now(),
                    //   ),
                    //   Activity(
                    //     name: 'act',
                    //     colorCode: '529620',
                    //     iconPath: 'icons/activities/moon.svg',
                    //     time: Duration(hours: 4),
                    //     startDate: DateTime.now(),
                    //     endDate: DateTime.now(),
                    //   ),
                    //   Activity(
                    //     name: 'act',
                    //     colorCode: '529620',
                    //     iconPath: 'icons/activities/moon.svg',
                    //     time: Duration(hours: 4),
                    //     startDate: DateTime.now(),
                    //     endDate: DateTime.now(),
                    //   ),
                    //   Activity(
                    //     name: 'act',
                    //     colorCode: '529620',
                    //     iconPath: 'icons/activities/moon.svg',
                    //     time: Duration(hours: 4),
                    //     startDate: DateTime.now(),
                    //     endDate: DateTime.now(),
                    //   ),
                    // ]
                    children: _activityController.activities
                        .map(
                          (activity) => ActivityItem(
                            activity: activity,
                            onTap: () {
                              _activityController.setActivity(activity);
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.activity,
    required this.onTap,
  });
  final Activity activity;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: MyTheme.scaffoldBackgroundColor,
        ),
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              /// Activity icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: MyTheme.whiteColor,
                ),
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  child: SvgPicture.asset(
                    activity.iconPath,
                    colorFilter: ColorFilter.mode(
                      activity.color,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            activity.name,
                            style: const TextStyle(
                              color: MyTheme.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'icons/clock.svg',
                              width: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              formatDuration(activity.time),
                              style: const TextStyle(
                                color: MyTheme.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      final maxWidth = constraints.maxWidth;
                      final rand = Random().nextInt(60) + 21;
                      final width = maxWidth * (rand / 100);
                      return Stack(
                        children: [
                          Container(
                            width: maxWidth,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: MyTheme.whiteColor,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: Container(
                              height: 4,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(10),
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyTheme.whiteColor,
                ),
                child: FittedBox(
                  child: SvgPicture.asset(
                    'icons/arrow.svg',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
