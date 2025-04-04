import 'activity.dart';

class Plan {
  final String id;
  final String title;
  final List<Activity> activities;
  final DateTime startDate;
  final DateTime endDate;

  Plan({
    required this.id,
    required this.title,
    required this.activities,
    required this.startDate,
    required this.endDate,
  });
}
