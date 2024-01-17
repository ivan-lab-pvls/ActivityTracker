import 'dart:math' as math;

import 'package:activity_tracker/data/activity_controller.dart';
import 'package:activity_tracker/data/models/activity.dart';
import 'package:activity_tracker/my_flat_button.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:activity_tracker/screen/create_activity/widgets/second_create_step_body.dart';
import 'package:activity_tracker/screen/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

const List<Color> colors = [
  MyTheme.orange,
  MyTheme.red,
  MyTheme.yellow,
  MyTheme.darkGreen,
  MyTheme.darkBlue,
  MyTheme.lightGreen,
  MyTheme.purple,
  MyTheme.blue,
  MyTheme.grey,
];

const List<String> icons = [
  'icons/activities/apple.svg',
  'icons/activities/bag.svg',
  'icons/activities/ball.svg',
  'icons/activities/barbell.svg',
  'icons/activities/camera.svg',
  'icons/activities/cup.svg',
  'icons/activities/moon_solid.svg',
  'icons/activities/moon.svg',
  'icons/activities/pop_corn.svg',
  'icons/activities/roll.svg',
  'icons/activities/rugby.svg',
  'icons/activities/sleep.svg',
  'icons/activities/smile.svg',
  'icons/activities/swim.svg',
  'icons/activities/walk.svg',
  'icons/activities/youtube.svg',
];

enum CreateStep {
  first,
  second,
}

class CreateActivityScreen extends StatefulWidget {
  const CreateActivityScreen({super.key});

  @override
  State<CreateActivityScreen> createState() => _CreateActivityScreenState();
}

class _CreateActivityScreenState extends State<CreateActivityScreen> {
  var _step = CreateStep.first;
  Color? _pickedColor;
  String? _pickedIconPath;

  Duration? _duration;
  DateTimeRange? _dateRange;

  final TextEditingController _controller = TextEditingController();

  late final ActivityController _activityController;

  @override
  void initState() {
    super.initState();
    _activityController = context.read<ActivityController>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: UnconstrainedBox(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyTheme.whiteColor,
                ),
                width: 32,
                height: 32,
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  child: Transform.rotate(
                    angle: math.pi,
                    child: SvgPicture.asset('icons/arrow.svg'),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: InkWell(
                onTap: () {
                  if (_dateRange != null &&
                      _duration != null &&
                      _pickedColor != null &&
                      _pickedIconPath != null &&
                      _controller.text.isNotEmpty) {
                    final activity = Activity(
                      name: _controller.text,
                      colorCode: colorToCode(_pickedColor!),
                      iconPath: _pickedIconPath!,
                      time: _duration!,
                      startDate: _dateRange!.start,
                      endDate: _dateRange!.end,
                    );
                    _activityController.addActivity(activity);

                    Navigator.of(context).pop();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    'Create activity',
                    style: TextStyle(
                      color: MyTheme.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _step == CreateStep.first
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Name tracker',
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _controller,
                        cursorColor: MyTheme.blackColor,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Example (Walk)',
                          fillColor: MyTheme.whiteColor,
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Color',
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.all(16),
                        decoration: BoxDecoration(
                          color: MyTheme.whiteColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          children: colors
                              .map(
                                (e) => ColorItem(
                                  color: e,
                                  selected: e == _pickedColor,
                                  onTap: () => setState(
                                    () {
                                      _pickedColor = e;
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Color',
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.all(16),
                        decoration: BoxDecoration(
                          color: MyTheme.whiteColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Wrap(
                          spacing: 24,
                          runSpacing: 20,
                          children: icons
                              .map(
                                (e) => IconItem(
                                  iconPath: e,
                                  selected: e == _pickedIconPath,
                                  onTap: () => setState(
                                    () {
                                      _pickedIconPath = e;
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      MyFlatButton(
                        onTap: () {
                          setState(() {
                            _step = CreateStep.second;
                          });
                        },
                        text: 'Next',
                      ),
                    ],
                  )
                : SecondCreateStepBody(
                    onDurationPick: (duration) => setState(() {
                      _duration = duration;
                    }),
                    onDateRangePick: (dateRange) => setState(() {
                      _dateRange = dateRange;
                    }),
                    dateRange: _dateRange,
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
      ),
    );
  }
}

class IconItem extends StatefulWidget {
  const IconItem({
    super.key,
    required this.iconPath,
    required this.onTap,
    required this.selected,
  });
  final String iconPath;
  final VoidCallback onTap;
  final bool selected;

  @override
  State<IconItem> createState() => _IconItemState();
}

class _IconItemState extends State<IconItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _containerAnimation;
  late Animation _iconAnimation;

  @override
  void didChangeDependencies() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _containerAnimation =
        ColorTween(begin: null, end: MyTheme.scaffoldBackgroundColor).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _iconAnimation = ColorTween(
            begin: Theme.of(context).primaryColor, end: MyTheme.blackColor)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(IconItem oldWidget) {
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _containerAnimation.value,
            ),
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              widget.iconPath,
              colorFilter: ColorFilter.mode(
                _iconAnimation.value,
                BlendMode.srcIn,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorItem extends StatefulWidget {
  const ColorItem({
    super.key,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
        width: 32,
        height: 32,
        alignment: Alignment.center,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: widget.selected ? 1 : 0,
          child: SvgPicture.asset(
            'icons/check.svg',
          ),
        ),
      ),
    );
  }
}
