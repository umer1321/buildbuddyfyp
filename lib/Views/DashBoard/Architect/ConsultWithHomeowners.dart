import 'package:flutter/material.dart';

class ConsultHomeownersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consult Homeowners'),
        backgroundColor: Colors.orange[800],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading Section
            const Text(
              'Scheduled Consultations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 16),

            // List of upcoming consultations (example)
            _buildConsultationCard(
              context,
              homeowner: 'John Doe',
              project: 'Kitchen Remodel',
              date: 'December 15, 2024',
            ),
            _buildConsultationCard(
              context,
              homeowner: 'Jane Smith',
              project: 'Bathroom Renovation',
              date: 'December 18, 2024',
            ),
            _buildConsultationCard(
              context,
              homeowner: 'Sam Wilson',
              project: 'Living Room Overhaul',
              date: 'December 20, 2024',
            ),

            // Spacer
            const Spacer(),

            // Add Consultation Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to schedule a consultation screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleConsultationScreen()),
                );
              },
              icon: const Icon(Icons.add_circle_outline, size: 30),
              label: const Text('Schedule a Consultation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build a consultation card
  Widget _buildConsultationCard(BuildContext context,
      {required String homeowner, required String project, required String date}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.home,
              size: 40,
              color: Colors.orange[800],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeowner,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Project: $project',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Date: $date',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: 30,
              color: Colors.orange[800],
            ),
          ],
        ),
      ),
    );
  }
}

///


class ScheduleConsultationScreen extends StatefulWidget {
  @override
  _ScheduleConsultationScreenState createState() => _ScheduleConsultationScreenState();
}

class _ScheduleConsultationScreenState extends State<ScheduleConsultationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form input
  final TextEditingController _homeownerController = TextEditingController();
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final homeowner = _homeownerController.text;
      final project = _projectController.text;
      final date = _dateController.text;
      final time = _timeController.text;

      // Print the submitted data (you can send this data to your backend or database)
      print('Homeowner: $homeowner');
      print('Project: $project');
      print('Date: $date');
      print('Time: $time');

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consultation scheduled successfully!')),
      );

      // Go back to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Consultation'),
        backgroundColor: Colors.orange[800],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Homeowner Name Input
              TextFormField(
                controller: _homeownerController,
                decoration: const InputDecoration(
                  labelText: 'Homeowner Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the homeowner\'s name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Project Type Input
              TextFormField(
                controller: _projectController,
                decoration: const InputDecoration(
                  labelText: 'Project Type',
                  prefixIcon: Icon(Icons.home_repair_service),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the project type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date Input
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Time Input
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  prefixIcon: Icon(Icons.access_time),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Schedule Consultation'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
