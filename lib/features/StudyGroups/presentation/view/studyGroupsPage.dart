import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/studygroupcard.dart';

class StudyGroupPage extends ConsumerStatefulWidget {
  const StudyGroupPage({Key? key}) : super(key: key);

  @override
  _StudyGroupPageState createState() => _StudyGroupPageState();
}

class _StudyGroupPageState extends ConsumerState<StudyGroupPage> {
  List<Map<String, dynamic>> studyGroups = [
    {
      'groupName': 'Physics Study Group',
      'description': 'A group for all physics enthusiasts.',
      'createdBy': 'Alice',
      'members': 10,
    },
    {
      'groupName': 'Math Wizards',
      'description': 'Solving math problems together.',
      'createdBy': 'Bob',
      'members': 8,
    },
    {
      'groupName': 'Biology Buddies',
      'description': 'Discussing everything about biology.',
      'createdBy': 'Charlie',
      'members': 12,
    },
  ];

  List<Map<String, dynamic>> filteredGroups = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredGroups = studyGroups;
    searchController.addListener(_filterStudyGroups);
  }

  void _filterStudyGroups() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredGroups = studyGroups.where((group) {
        return group['groupName'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showCreateGroupDialog() {
    final groupNameController = TextEditingController();
    final descriptionController = TextEditingController();
    final createdByController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Create New Study Group',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: groupNameController,
                        decoration: InputDecoration(
                          labelText: 'Group Name',
                          border: OutlineInputBorder(),
                          hintText: 'Enter the group name',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          hintText: 'Enter the group description',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: createdByController,
                        decoration: InputDecoration(
                          labelText: 'Created By',
                          border: OutlineInputBorder(),
                          hintText: 'Enter your name',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              backgroundColor: Colors.deepPurple.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 6,
            ),
            onPressed: () {
              final groupName = groupNameController.text;
              final description = descriptionController.text;
              final createdBy = createdByController.text;

              if (groupName.isNotEmpty && description.isNotEmpty && createdBy.isNotEmpty) {
                setState(() {
                  studyGroups.add({
                    'groupName': groupName,
                    'description': description,
                    'createdBy': createdBy,
                    'members': 1,
                  });
                });
                Navigator.of(context).pop();
              }
            },
            child: Text('Create', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Study Groups',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: _showCreateGroupDialog,
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Explore Study Groups',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.deepPurple.shade700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search by group name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (searchController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.deepPurple),
                        onPressed: () {
                          searchController.clear();
                          _filterStudyGroups(); // Clear the filter
                        },
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredGroups.length,
                itemBuilder: (context, index) {
                  final group = filteredGroups[index];
                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 500 + index * 200),
                    opacity: 1.0,
                    child: Column(
                      children: [
                        StudyGroupCard(
                          groupName: group['groupName'],
                          description: group['description'],
                          createdBy: group['createdBy'],
                          members: group['members'],

                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          thickness: 1,
                          color: Colors.deepPurple.shade200,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
