import 'package:app_diario/models/plan.dart';
import 'package:flutter/material.dart';

class PlanCard extends StatefulWidget {
  final Plan plan;
  final Function() onUpdate;

  const PlanCard({super.key, required this.plan, required this.onUpdate});

  @override
  // ignore: library_private_types_in_public_api
  _PlanCardState createState() => _PlanCardState();
}

@override
class _PlanCardState extends State<PlanCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
