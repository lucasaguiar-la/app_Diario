import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/plan.dart';
import '../models/activity.dart';

class PlanFormScreen extends StatefulWidget {
  const PlanFormScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlanFormScreenState createState() => _PlanFormScreenState();
}

class _PlanFormScreenState extends State<PlanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _activityController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 30));

  final List<Activity> _activities = [];
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Novo Plano')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Campo de título
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título do Plano',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um título';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Seleção de data de início
            ListTile(
              title: Text('Data de Início'),
              subtitle: Text(_formatDate(_startDate)),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, true),
            ),
            Divider(),

            // Seleção de data de término
            ListTile(
              title: Text('Data de Término'),
              subtitle: Text(_formatDate(_endDate)),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, false),
            ),
            Divider(),

            // Seção de atividades
            Text(
              'Atividades',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Lista de atividades adicionadas
            ..._activities.map(
              (activity) => ListTile(
                title: Text(activity.title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _activities.remove(activity);
                    });
                  },
                ),
              ),
            ),

            // Novas atividades
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _activityController,
                    decoration: InputDecoration(
                      labelText: 'Nova Atividade',
                      hintText: 'Digite o nome da atividade',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_activityController.text.isNotEmpty) {
                      setState(() {
                        _activities.add(
                          Activity(
                            id: uuid.v4(),
                            title: _activityController.text,
                            completionStatus: false,
                          ),
                        );
                        _activityController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 24),

            // Botão salvar
            ElevatedButton(
              onPressed: _savePlan,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Salvar Plano'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context, bool isStartDate) async {
    final initialDate = isStartDate ? _startDate : _endDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isStartDate ? DateTime.now() : _startDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          // Se a data de início for depois da data de término, atualiza a data de término
          if (_startDate.isAfter(_endDate)) {
            _endDate = _startDate.add(Duration(days: 30));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _savePlan() {
    if (_formKey.currentState!.validate()) {
      if (_activities.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Adicione pelo menos uma atividade')),
        );
        return;
      }

      final newPlan = Plan(
        id: uuid.v4(),
        title: _titleController.text,
        activities: _activities,
        startDate: _startDate,
        endDate: _endDate,
      );

      Navigator.of(context).pop(newPlan);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
