import 'package:flutter/material.dart';

class MyProjectsDashboard extends StatefulWidget {
  const MyProjectsDashboard({super.key});

  @override
  _MyProjectsDashboardState createState() => _MyProjectsDashboardState();
}

class _MyProjectsDashboardState extends State<MyProjectsDashboard> {
  final List<Map<String, dynamic>> _projects = [
    {'title': 'Kitchen Renovation', 'status': 'In Progress', 'progress': 50},
    {'title': 'Living Room Remodeling', 'status': 'Completed', 'progress': 100},
    {'title': 'Garage Upgrade', 'status': 'Pending', 'progress': 0},
  ];

  String _selectedFilter = 'All';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 8.0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchBar(),
                const SizedBox(height: 10),
                _buildFilterDropdown(),
                const SizedBox(height: 20),
                Expanded(child: _buildProjectList()),
              ],
            ),
          ),
          _buildBackgroundCircles(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToProjectCreation,
        child: const Icon(Icons.add, size: 30),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 6,
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Projects...',
        prefixIcon: const Icon(Icons.search, color: Color(0xFF4CAF50)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value.toLowerCase();
        });
      },
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedFilter,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[100],
        prefixIcon: const Icon(Icons.filter_list, color: Color(0xFF4CAF50)),
      ),
      items: ['All', 'In Progress', 'Completed', 'Pending']
          .map((filter) => DropdownMenuItem(
        value: filter,
        child: Text(filter),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedFilter = value!;
        });
      },
    );
  }

  Widget _buildProjectList() {
    final filteredProjects = _projects.where((project) {
      final matchesSearch = project['title']!.toLowerCase().contains(_searchQuery);
      final matchesFilter = _selectedFilter == 'All' || project['status'] == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    if (filteredProjects.isEmpty) {
      return const Center(
        child: Text(
          'No projects found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) {
        final project = filteredProjects[index];
        return GestureDetector(
          onTap: () => _navigateToProjectDetails(project),
          child: ProjectCard(
            title: project['title']!,
            status: project['status']!,
            progress: project['progress']!,
          ),
        );
      },
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          bottom: -80,
          left: -100,
          child: Container(
            width: 360,
            height: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE8EAF6),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          right: -80,
          child: Container(
            width: 360,
            height: 250,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF1F8E9),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToProjectDetails(Map<String, dynamic> project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(project: project),
      ),
    );
  }

  void _navigateToProjectCreation() async {
    final newProject = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => const ProjectCreationScreen(),
      ),
    );

    if (newProject != null) {
      setState(() {
        _projects.add(newProject);
      });
    }
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String status;
  final int progress;

  const ProjectCard({
    required this.title,
    required this.status,
    required this.progress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Status: $status', style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[200],
              color: Colors.green,
            ),
            const SizedBox(height: 4),
            Text('$progress% Completed', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class ProjectDetailScreen extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailScreen({required this.project, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details: ${project['title']}'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project: ${project['title']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Status: ${project['status']}'),
            const SizedBox(height: 20),
            const Text(
              'Progress:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: project['progress'] / 100,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            Text('${project['progress']}% Completed'),
            const SizedBox(height: 20),
            const Text(
              'Detailed information about the project will go here.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


class ProjectCreationScreen extends StatefulWidget {
  const ProjectCreationScreen({super.key});

  @override
  _ProjectCreationScreenState createState() => _ProjectCreationScreenState();
}

class _ProjectCreationScreenState extends State<ProjectCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String _status = 'In Progress';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Project'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Project Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Project Title',
                      labelStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      prefixIcon: const Icon(Icons.title, color: Color(0xFF4CAF50)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a project title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _status,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      labelStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      prefixIcon: const Icon(Icons.info, color: Color(0xFF4CAF50)),
                    ),
                    items: ['In Progress', 'Completed', 'Pending']
                        .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _status = value!;
                      });
                    },
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _submitProject,
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text('Add Project'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: const Color(0xFF4CAF50),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitProject() {
    if (_formKey.currentState!.validate()) {
      final newProject = {
        'title': _titleController.text,
        'status': _status,
        'progress': _status == 'Completed' ? 100 : 0,
      };

      Navigator.pop(context, newProject);
    }
  }
}






















/*
import 'package:flutter/material.dart';

class MyProjectsDashboard extends StatefulWidget {
  const MyProjectsDashboard({super.key});

  @override
  _MyProjectsDashboardState createState() => _MyProjectsDashboardState();
}

class _MyProjectsDashboardState extends State<MyProjectsDashboard> {
  final List<Map<String, String>> _projects = [
    {'title': 'Kitchen Renovation', 'status': 'In Progress'},
    {'title': 'Living Room Remodeling', 'status': 'Completed'},
    {'title': 'Garage Upgrade', 'status': 'Pending'},
  ];

  String _selectedFilter = 'All';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchBar(),
                _buildFilterDropdown(),
                const SizedBox(height: 10),
                Expanded(child: _buildProjectList()),
              ],
            ),
          ),
          _buildBackgroundCircles(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToProjectCreation,
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Projects...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value.toLowerCase();
        });
      },
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButton<String>(
      value: _selectedFilter,
      items: ['All', 'In Progress', 'Completed', 'Pending']
          .map((filter) => DropdownMenuItem(
        value: filter,
        child: Text(filter),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedFilter = value!;
        });
      },
    );
  }

  Widget _buildProjectList() {
    final filteredProjects = _projects.where((project) {
      final matchesSearch = project['title']!.toLowerCase().contains(_searchQuery);
      final matchesFilter = _selectedFilter == 'All' ||
          project['status'] == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    if (filteredProjects.isEmpty) {
      return const Center(child: Text('No projects found.'));
    }

    return ListView.builder(
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) {
        final project = filteredProjects[index];
        return GestureDetector(
          onTap: () => _navigateToProjectDetails(project['title']!),
          child: ProjectCard(
            title: project['title']!,
            status: project['status']!,
          ),
        );
      },
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          bottom: -80,
          left: -100,
          child: Container(
            width: 360,
            height: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE8EAF6),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          right: -80,
          child: Container(
            width: 360,
            height: 250,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF1F8E9),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToProjectDetails(String projectTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(projectTitle: projectTitle),
      ),
    );
  }

  void _navigateToProjectCreation() async {
    final newProject = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => const ProjectCreationScreen(),
      ),
    );

    if (newProject != null) {
      setState(() {
        _projects.add(newProject);
      });
    }
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String status;

  const ProjectCard({required this.title, required this.status, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Status: $status'),
        trailing: Icon(
          status == 'Completed' ? Icons.check_circle : Icons.pending_actions,
          color: status == 'Completed' ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}

class ProjectDetailScreen extends StatelessWidget {
  final String projectTitle;

  const ProjectDetailScreen({required this.projectTitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details: $projectTitle'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Center(
        child: Text('Detailed information about $projectTitle.'),
      ),
    );
  }
}

class ProjectCreationScreen extends StatefulWidget {
  const ProjectCreationScreen({super.key});

  @override
  _ProjectCreationScreenState createState() => _ProjectCreationScreenState();
}

class _ProjectCreationScreenState extends State<ProjectCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String _status = 'In Progress';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Project'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Project Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project title';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['In Progress', 'Completed', 'Pending']
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProject,
                child: const Text('Add Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitProject() {
    if (_formKey.currentState!.validate()) {
      final newProject = {
        'title': _titleController.text,
        'status': _status,
      };

      Navigator.pop(context, newProject);
    }
  }
}
*/





/*import 'package:flutter/material.dart';

class MyProjectsDashboard extends StatelessWidget {
  const MyProjectsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ProjectCard(
                  title: 'Kitchen Renovation',
                  status: 'In Progress',
                  onViewDetails: () => _showDetails(context, 'Kitchen Renovation'),
                  onEdit: () => _editProject(context, 'Kitchen Renovation'),
                  onDelete: () => _deleteProject(context, 'Kitchen Renovation'),
                ),
                ProjectCard(
                  title: 'Living Room Remodeling',
                  status: 'Completed',
                  onViewDetails: () => _showDetails(context, 'Living Room Remodeling'),
                  onEdit: () => _editProject(context, 'Living Room Remodeling'),
                  onDelete: () => _deleteProject(context, 'Living Room Remodeling'),
                ),
                ProjectCard(
                  title: 'Garage Upgrade',
                  status: 'Pending',
                  onViewDetails: () => _showDetails(context, 'Garage Upgrade'),
                  onEdit: () => _editProject(context, 'Garage Upgrade'),
                  onDelete: () => _deleteProject(context, 'Garage Upgrade'),
                ),
              ],
            ),
          ),
          // Positioned decorative elements
          Positioned(
            bottom: -80,
            left: -100,
            child: Container(
              width: 360,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE8EAF6),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -80,
            child: Container(
              width: 360,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF1F8E9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, String projectTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Project Details'),
        content: Text('Details for $projectTitle'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _editProject(BuildContext context, String projectTitle) {
    // Navigate to Edit Project screen (replace with your own logic)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Edit $projectTitle')),
          body: Center(child: Text('Edit form for $projectTitle')),
        ),
      ),
    );
  }

  void _deleteProject(BuildContext context, String projectTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Project'),
        content: Text('Are you sure you want to delete $projectTitle?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement delete logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$projectTitle deleted.')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback onViewDetails;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProjectCard({
    required this.title,
    required this.status,
    required this.onViewDetails,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Status: $status'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'View Details') onViewDetails();
            if (value == 'Edit') onEdit();
            if (value == 'Delete') onDelete();
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'View Details', child: Text('View Details')),
            const PopupMenuItem(value: 'Edit', child: Text('Edit')),
            const PopupMenuItem(value: 'Delete', child: Text('Delete')),
          ],
        ),
        leading: Icon(
          status == 'Completed' ? Icons.check_circle : Icons.pending_actions,
          color: status == 'Completed' ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}*/













/*
import 'package:flutter/material.dart';

class MyProjectsDashboard extends StatelessWidget {
  const MyProjectsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ProjectCard(title: 'Kitchen Renovation', status: 'In Progress'),
                ProjectCard(title: 'Living Room Remodeling', status: 'Completed'),
                ProjectCard(title: 'Garage Upgrade', status: 'Pending'),
              ],
            ),
          ),
          // Positioned elements at the bottom
          Positioned(
            bottom: -80,
            left: -100,
            child: Container(
              width: 360,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE8EAF6), // Light blue
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -80,
            child: Container(
              width: 360,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF1F8E9), // Light green
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String status;

  const ProjectCard({required this.title, required this.status, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Status: $status'),
        trailing: Icon(
          status == 'Completed'
              ? Icons.check_circle
              : Icons.pending_actions,
          color: status == 'Completed' ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}
*/
