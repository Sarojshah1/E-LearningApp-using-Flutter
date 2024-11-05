import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/study_group_viewModel.dart';
import '../widgets/studygroupcard.dart';

class StudyGroupPage extends ConsumerStatefulWidget {
  const StudyGroupPage({Key? key}) : super(key: key);

  @override
  _StudyGroupPageState createState() => _StudyGroupPageState();
}

class _StudyGroupPageState extends ConsumerState<StudyGroupPage> {


  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    Future.microtask(() {
      ref.read(studyGroupViewModelProvider.notifier).getGroups();
    });

  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCreateGroupDialog() {
    final groupNameController = TextEditingController();
    final descriptionController = TextEditingController();

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
            onPressed: () async{
              final groupName = groupNameController.text;
              final description = descriptionController.text;


              if (groupName.isNotEmpty && description.isNotEmpty) {

                final viewModel=ref.read(studyGroupViewModelProvider.notifier);
                await viewModel.createGroups(groupName, description);
                final state=ref.read(studyGroupViewModelProvider);

                if(state.error != null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('something went wrong')),
                  );

                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Group Created Successfully')),
                  );

                }

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
    final state=ref.watch(studyGroupViewModelProvider);
    final filteredGroups=state.studyGroups.where((group) {
      return group.groupName.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search by group name',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value; // Update _searchQuery with the input value
                          });
                        },
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.deepPurple),
                        onPressed: () {
                          _searchController.clear();


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
                          groupId: group.id!,
                          groupName: group.groupName,
                          description: group.description,
                          createdBy: group.createdBy,
                          members: group.members.length,

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
