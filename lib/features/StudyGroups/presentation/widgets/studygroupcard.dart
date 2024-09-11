import 'package:flutter/material.dart';

class StudyGroupCard extends StatelessWidget {
  final String groupName;
  final String description;
  final String createdBy;
  final int members;


  const StudyGroupCard({
    Key? key,
    required this.groupName,
    required this.description,
    required this.createdBy,
    required this.members,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.1),
              blurRadius: 8.0,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group name and creator info
            Row(
              children: [
                Icon(Icons.groups, color: Colors.deepPurple, size: 32),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    groupName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.deepPurple.shade900,
                    ),
                  ),
                ),
                Icon(Icons.person, color: Colors.deepPurple),
                SizedBox(width: 5.0),
                Text(
                  createdBy,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.0),
            // Member list
            Row(
              children: [
                Icon(Icons.group, color: Colors.deepPurple),
                SizedBox(width: 8.0),
                Text(
                  "$members members",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            // Join button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: (){

                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text('Join Group',style: TextStyle(color: Colors.white,),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Colors.deepPurple.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 6,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
