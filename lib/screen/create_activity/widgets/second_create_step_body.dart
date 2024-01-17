import 'package:activity_tracker/my_flat_button.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SecondCreateStepBody extends StatefulWidget {
  const SecondCreateStepBody({
    super.key,
    this.dateRange,
    required this.onDurationPick,
    required this.onDateRangePick,
  });

  final DateTimeRange? dateRange;
  final void Function(Duration) onDurationPick;
  final void Function(DateTimeRange) onDateRangePick;

  @override
  State<SecondCreateStepBody> createState() => _SecondCreateStepBodyState();
}

class _SecondCreateStepBodyState extends State<SecondCreateStepBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(_update);
  }

  void _update() => setState(() {});

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: MyTheme.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyTheme.scaffoldBackgroundColor,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth * 0.5;
                    return Stack(
                      children: [
                        AnimatedPositioned(
                          left: width * _tabController.index,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            height: constraints.maxHeight,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: MyTheme.whiteColor,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => _tabController.index = 0,
                                child: Center(
                                  child: Text(
                                    'Time',
                                    style: TextStyle(
                                      color: MyTheme.blackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => _tabController.index = 1,
                                child: Center(
                                  child: Text(
                                    'Date',
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
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose the time frame during\nwhich you will track your activity.',
                style: TextStyle(
                  color: MyTheme.blackColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 360,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: MyTheme.scaffoldBackgroundColor,
                      ),
                      child: CupertinoTimerPicker(
                        onTimerDurationChanged: (Duration value) {
                          widget.onDurationPick(value);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: MyTheme.scaffoldBackgroundColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.dateRange == null
                                ? 'Pick date range'
                                : '${DateFormat('yyyy.MM.dd').format(widget.dateRange!.start)}-${DateFormat('yyyy.MM.dd').format(widget.dateRange!.end)}',
                            textAlign: TextAlign.center,
                          ),
                          MyFlatButton(
                            onTap: () async {
                              final result = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 365)),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              );
                              if (result == null) {
                                return;
                              }
                              widget.onDateRangePick(result);
                            },
                            text: 'Pick date range',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
