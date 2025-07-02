import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class CommunitiesTab extends StatefulWidget {
  const CommunitiesTab({super.key});

  @override
  State<CommunitiesTab> createState() => _CommunitiesTabState();
}

class _CommunitiesTabState extends State<CommunitiesTab> {
  final Set<String> _joining = {};
  final Set<String> _leaving = {};

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Center(child: Text('Please sign in'));

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) return const Center(child: CircularProgressIndicator());

        final joined = List<String>.from(userSnapshot.data?['joined_communities'] ?? []);

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('community_rooms').snapshots(),
          builder: (context, roomSnapshot) {
            if (!roomSnapshot.hasData) return const Center(child: CircularProgressIndicator());

            final allRooms = roomSnapshot.data!.docs;
            final joinedRooms = allRooms.where((doc) => joined.contains(doc.id)).toList();
            final notJoinedRooms = allRooms.where((doc) => !joined.contains(doc.id)).toList();

            return ListView(
              padding: const EdgeInsets.all(8),
              children: [
                if (joinedRooms.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 12, bottom: 6),
                    child: Text("Joined Communities", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ...joinedRooms.map((room) {
                  final isLeaving = _leaving.contains(room.id);
                  return ListTile(
                    title: Text(room['name']),
                    subtitle: Text(room['description']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check, color: Colors.green),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: isLeaving
                              ? null
                              : () async {
                            setState(() => _leaving.add(room.id));
                            await FirebaseFirestore.instance.collection('users').doc(uid).update({
                              'joined_communities': FieldValue.arrayRemove([room.id]),
                            });
                            setState(() => _leaving.remove(room.id));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Left ${room['name']}")),
                            );
                          },
                          child: isLeaving
                              ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : const Text("Leave"),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                chatPath: 'community_rooms/${room.id}/chats',
                                communityId: room.id,
                              ),
                            ));
                          },
                        )
                      ],
                    ),
                  );
                }).toList(),
                if (joinedRooms.isNotEmpty && notJoinedRooms.isNotEmpty)
                  const Divider(thickness: 1, height: 32),
                if (notJoinedRooms.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 6),
                    child: Text("Other Communities", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ...notJoinedRooms.map((room) {
                  final isJoining = _joining.contains(room.id);
                  return ListTile(
                    title: Text(room['name']),
                    subtitle: Text(room['description']),
                    trailing: ElevatedButton(
                      onPressed: isJoining
                          ? null
                          : () async {
                        setState(() => _joining.add(room.id));
                        await FirebaseFirestore.instance.collection('users').doc(uid).update({
                          'joined_communities': FieldValue.arrayUnion([room.id])
                        });
                        setState(() => _joining.remove(room.id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Joined ${room['name']}")),
                        );
                      },
                      child: isJoining
                          ? const SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : const Text('Join'),
                    ),
                  );
                }).toList(),
              ],
            );
          },
        );
      },
    );
  }
}
