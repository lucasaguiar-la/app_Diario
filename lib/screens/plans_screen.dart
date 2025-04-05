import 'package:app_diario/widgets/plan_card.dart';
import 'package:flutter/material.dart';
//import '../models/user.dart';
import '../models/plan.dart';
import '../models/activity.dart';
import 'plan_form_screen.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  List<Plan> _plans = [];

  @override
  void initState() {
    super.initState();
    _loadSamplePlans();
  }

  void _loadSamplePlans() {
    final activity1 = Activity(
      id: '1',
      title: 'Ler 30 minutos',
      completionStatus: false,
    );

    final activity2 = Activity(
      id: '2',
      title: 'Fazer exercícios',
      completionStatus: false,
    );

    setState(() {
      _plans = [
        Plan(
          id: '1',
          title: 'Hábitos Saudáveis',
          activities: [activity1, activity2],
          startDate: DateTime.now().subtract(Duration(days: 7)),
          endDate: DateTime.now().add(Duration(days: 23)),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Planos')),
      body:
          _plans.isEmpty
              ? Center(child: Text('Você ainda não tem planos. Crie um novo!'))
              : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  return PlanCard(
                    plan: _plans[index],
                    onUpdate: () {
                      setState(() {});
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPlan = await Navigator.of(context).push<Plan>(
            MaterialPageRoute(builder: (context) => PlanFormScreen()),
          );

          if (newPlan != null) {
            setState(() {
              _plans.add(newPlan);
            });
          }
        },
        tooltip: 'Adicionar Plano',
        child: Icon(Icons.add),
      ),
    );
  }
}
