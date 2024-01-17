import 'dart:convert';

import 'package:activity_tracker/data/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _activityKey = '_activityKey';
const String _activitiesKey = '_activitiesKey';

class ActivityController extends ChangeNotifier {
  ActivityController(this._bd) {
    _init();
  }
  final SharedPreferences _bd;

  Activity? _activeActivity;
  List<Activity> _activities = [];
  Activity? get activeActivity => _activeActivity;
  List<Activity> get activities => _activities;

  void setActivity(Activity activity) {
    _activeActivity = activity;
    _cacheActivity();
    notifyListeners();
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    _cacheActivities();
    notifyListeners();
  }

  void deleteActivity(Activity activity) {
    _activities.remove(activity);
    _activeActivity = _activities.isNotEmpty ? _activities.first : null;
    _cacheActivities();
    _cacheActivity();
    notifyListeners();
  }

  void _init() {
    final activityStr = _bd.getString(_activityKey) ?? '';
    if (activityStr.isNotEmpty) {
      final activityJson = jsonDecode(activityStr);

      _activeActivity = Activity.fromJson(activityJson);
    }

    final activitiesStr = _bd.getString(_activitiesKey) ?? '';
    if (activitiesStr.isNotEmpty) {
      final activitiesJson = jsonDecode(activitiesStr) as List<dynamic>;
      _activities = activitiesJson.map((e) => Activity.fromJson(e)).toList();
    }

    notifyListeners();
  }

  void _cacheActivity() async {
    if (_activeActivity == null) {
      await _bd.remove(_activityKey);
      return;
    }
    final json = jsonEncode(_activeActivity?.toJson());
    await _bd.setString(_activityKey, json);
  }

  void _cacheActivities() async {
    if (_activities.isEmpty) {
      await _bd.remove(_activitiesKey);
      return;
    }
    final json = jsonEncode(_activities.map((e) => e.toJson()).toList());
    await _bd.setString(_activitiesKey, json);
  }
}
