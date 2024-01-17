import 'package:activity_tracker/data/activity_controller.dart';
import 'package:activity_tracker/my_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityChart extends StatefulWidget {
  const ActivityChart({super.key, required this.activityController});
  final ActivityController activityController;
  @override
  State<ActivityChart> createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(_update);
  }

  void _update() => setState(() {});
  DateTime get now => DateTime.now();

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: MyTheme.whiteColor,
        ),
        child: Column(
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
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: MyTheme.scaffoldBackgroundColor,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final date = now
                                .subtract(const Duration(days: 6))
                                .add(Duration(days: rodIndex));
                            return BarTooltipItem(
                              DateFormat('yyyy.MM.dd').format(date),
                              TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          },
                        ),
                      ),
                      alignment: BarChartAlignment.spaceEvenly,
                      titlesData: const FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => const FlLine(
                          strokeWidth: 0.5,
                          color: MyTheme.greyColor,
                        ),
                      ),
                      borderData: FlBorderData(
                        border: Border.all(color: MyTheme.greyColor),
                      ),
                      minY: 0,
                      maxY: 100,
                      barGroups: [
                        BarChartGroupData(
                          barsSpace: 24,
                          x: 5,
                          barRods: List.generate(
                            7,
                            (index) {
                              final date = now
                                  .subtract(const Duration(days: 6))
                                  .add(Duration(days: index));
                              return BarChartRodData(
                                  width: 16,
                                  borderRadius: BorderRadius.circular(0),
                                  toY: date.isEqual(now) ? 50 : 3,
                                  color: date.isEqual(now)
                                      ? widget.activityController.activeActivity
                                              ?.color ??
                                          MyTheme.greyColor
                                      : MyTheme.greyColor);
                            },
                          ),
                        ),
                      ],
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 200),
                    swapAnimationCurve: Curves.linear,
                  ),
                  BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: MyTheme.scaffoldBackgroundColor,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final date = now
                                .subtract(const Duration(days: 6))
                                .add(Duration(days: rodIndex));
                            return BarTooltipItem(
                              DateFormat('yyyy.MM.dd').format(date),
                              TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          },
                        ),
                      ),
                      alignment: BarChartAlignment.spaceEvenly,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          strokeWidth: 0.5,
                          color: MyTheme.greyColor,
                        ),
                      ),
                      borderData: FlBorderData(
                        border: Border.all(color: MyTheme.greyColor),
                      ),
                      minY: 0,
                      maxY: 100,
                      barGroups: [
                        BarChartGroupData(
                          barsSpace: 5,
                          x: 5,
                          barRods: List.generate(
                            30,
                            (index) {
                              final date = now
                                  .subtract(const Duration(days: 29))
                                  .add(Duration(days: index));
                              return BarChartRodData(
                                  width: 5,
                                  borderRadius: BorderRadius.circular(0),
                                  toY: date.isEqual(now) ? 60 : 7,
                                  color: date.isEqual(now)
                                      ? widget.activityController.activeActivity
                                              ?.color ??
                                          MyTheme.greyColor
                                      : MyTheme.greyColor);
                            },
                          ),
                        ),
                      ],
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 200),
                    swapAnimationCurve: Curves.linear,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExt on DateTime {
  bool isEqual(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
