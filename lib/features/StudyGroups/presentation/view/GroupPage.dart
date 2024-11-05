import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/study_group_viewModel.dart';
import '../widgets/group_card.dart'; // Import the ViewModel

class JoinedGroupsPage extends ConsumerStatefulWidget {
  const JoinedGroupsPage({Key? key}) : super(key: key);

  @override
  _JoinedGroupsPageState createState() => _JoinedGroupsPageState();
}

class _JoinedGroupsPageState extends ConsumerState<JoinedGroupsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(studyGroupViewModelProvider.notifier).getGroupsByUsers();
    });

  }

  @override
  Widget build(BuildContext context) {
    final state=ref.watch(studyGroupViewModelProvider);
    final groups=state.studyGroups;

    return Scaffold(

      appBar: AppBar(
        title: Text('Joined Groups'),
        backgroundColor: Colors.deepPurple,
      ),
      body: state.isLoading
          ? Center(child: CircularProgressIndicator())
          : groups.isEmpty
          ? Center(child: Text('You have not joined any groups yet.'))
          : ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return GroupCard(
            groupId: group.id!,
            groupName: group.groupName,
            description: group.description,
            createdBy: group.createdBy,
            members: group.members.length,
          );
        },
      ),
    );
  }
}
