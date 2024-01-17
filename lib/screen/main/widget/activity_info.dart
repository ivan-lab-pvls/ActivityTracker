import 'dart:async';

import 'package:activity_tracker/data/activity_controller.dart';
import 'package:activity_tracker/data/models/activity.dart';
import 'package:activity_tracker/my_flat_button.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityInfo extends StatefulWidget {
  const ActivityInfo({super.key, required this.controller});
  final ActivityController controller;

  @override
  State<ActivityInfo> createState() => _ActivityInfoState();
}

class _ActivityInfoState extends State<ActivityInfo> {
  Timer _timer = Timer(Duration.zero, () {});
  Duration? _timeLeft;
  Activity? activity;
  var _finished = false;
  var _started = false;

  @override
  void initState() {
    super.initState();
    _listener();
    widget.controller.addListener(_listener);
  }

  void _listener() {
    if (activity != widget.controller.activeActivity) {
      activity = widget.controller.activeActivity;
      if (activity != null) {
        _timeLeft = activity!.time;
      } else {
        _timeLeft = null;
      }
      _timer.cancel();
      setState(() {
        _finished = false;
        _started = false;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: MyTheme.whiteColor,
        ),
        child: activity == null
            ? Center(
                child: Text(
                  'Choose activity',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Time goal',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              formatDuration(activity!.time),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: MyTheme.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                activity!.iconPath,
                                colorFilter: ColorFilter.mode(
                                  activity!.color,
                                  BlendMode.srcIn,
                                ),
                                width: 32,
                              ),
                              Text(
                                activity!.name,
                                style: const TextStyle(
                                  color: MyTheme.blackColor,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              widget.controller.deleteActivity(activity!);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Time left',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatDuration(_timeLeft ?? Duration.zero),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                            color: MyTheme.blackColor),
                      ),
                    ],
                  ),
                  MyFlatButton(
                    onTap: _onTap,
                    text: _finished
                        ? 'Restart'
                        : _started
                            ? 'Pause'
                            : 'Start',
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ],
              ),
      ),
    );
  }

  void _onTap() {
    if (_started) {
      /// Pause
      _timer.cancel();
      setState(() {
        _started = false;
      });
      return;
    }

    if (_finished && activity != null) {
      _timeLeft = activity!.time;
      setState(() {
        _finished = false;
      });
    }

    ///Start
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _timeLeft = Duration(seconds: _timeLeft!.inSeconds - 1);
          if (_timeLeft!.inSeconds == 0) {
            _finished = true;
            _started = false;
            _timer.cancel();
          }
        });
      },
    );
    setState(() {
      _started = true;
    });
  }
}
