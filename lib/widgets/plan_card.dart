import 'package:flutter/material.dart';
import '../models/plan.dart';
import '../models/activity.dart';
import '../screens/plan_details_screen.dart';

class PlanCard extends StatefulWidget {
  final Plan plan;
  final Function() onUpdate;

  const PlanCard({super.key, required this.plan, required this.onUpdate});

  @override
  // ignore: library_private_types_in_public_api
  _PlanCardState createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Column(
        children: [
          // Cabeçalho do cartão
          ListTile(
            title: Text(
              widget.plan.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Período: ${_formatDate(widget.plan.startDate)} a ${_formatDate(widget.plan.endDate)}',
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
            onTap: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder:
                          (context) => PlanDetailsScreen(plan: widget.plan),
                    ),
                  )
                  .then((_) {
                    widget.onUpdate();
                  });
            },
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 350),
            crossFadeState:
                _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            firstChild: Container(),
            secondChild: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Atividades:'),
                  SizedBox(height: 8),
                  ...widget.plan.activities.map((activity) {
                    return _buildActivityItem(activity);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Activity activity) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Checkbox(
            value: activity.completionStatus,
            onChanged: (value) async {
              setState(() {
                activity.completionStatus = value ?? false;
              });
              await Future.delayed(Duration(milliseconds: 100));
              widget.onUpdate.call();
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              style: TextStyle(
                fontSize: 16,
                decoration:
                    activity.completionStatus
                        ? TextDecoration.lineThrough
                        : null,
                color: Colors.black87,
              ),
              child: Text(activity.title),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
