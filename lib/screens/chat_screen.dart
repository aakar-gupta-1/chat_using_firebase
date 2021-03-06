import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter chat'),
        actions: [DropdownButton(icon: Icon(Icons.more_vert), items: [
          DropdownMenuItem(child: Container(child: Row(
            children: [
              Icon(Icons.exit_to_app),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),),
            value: 'logout',
          )
        ],
          onChanged: (itemIdentifier){
            FirebaseAuth.instance.signOut();
          },
        )],

      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/q219GOfqLMy2BooWquxB/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/q219GOfqLMy2BooWquxB/messages')
              .add({'text': 'This was added by clicking the button!'});
        },
      ),
    );
  }
}
