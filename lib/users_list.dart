import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UseresList extends StatefulWidget {
  const UseresList({Key? key}) : super(key: key);

  @override
  State<UseresList> createState() => _UseresListState();
}

class _UseresListState extends State<UseresList> {

  final CollectionReference _userLists = FirebaseFirestore.instance.collection('users');
  TextEditingController editName = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  TextEditingController editPhoneNumber = TextEditingController();
  TextEditingController editlocation = TextEditingController();

  Future<void> _update(

      [DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      editName.text = documentSnapshot['userName'];
      editEmail.text = documentSnapshot['emailId'];
      editlocation.text = documentSnapshot['location'];
      editPhoneNumber.text = documentSnapshot['phoneNumber'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            margin: EdgeInsets.all(19),
            height: 400,
            child: Column(
              children: [
                TextField(
                  controller: editName,
                  decoration:
                  const InputDecoration(labelText: "Edit Name"),
                ),
                TextField(
                  controller: editEmail,
                  decoration: const InputDecoration(
                      labelText: "Edit email"),
                ),
                TextField(
                  controller: editPhoneNumber,
                  decoration:
                  const InputDecoration(
                      labelText:
                      "Edit PhoneNumber"),
                ),
                TextField(
                  controller: editlocation,
                  decoration:
                  const InputDecoration(
                      labelText:
                      "Edit Location"),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      final String updateName = editName.text;
                      final String updatePhoneNumber = editPhoneNumber.text;
                      final String updateEmailid = editEmail.text;
                      final String updateLocation = editlocation.text;

                      await _userLists.doc(documentSnapshot!.id).update({
                        "userName": updateName,
                        "phoneNumber": updatePhoneNumber,
                        "emailId": updateEmailid,
                        "location": updateLocation
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Update"),
                  ),
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String users) async {
    await _userLists.doc(users).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User Deleted Successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Users List"),
        ),
        body: StreamBuilder(
          stream: _userLists.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(11),
                        child: ExpansionTile(
                          collapsedTextColor: Colors.black,
                          title: Text(
                            "User Name : ${documentSnapshot['userName']}",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                          // trailing: Row(
                          //   children: [
                          //     // IconButton(
                          //     //     onPressed: (){},
                          //     //     icon: Icon(Icons.edit)
                          //     // ),
                          //     // IconButton(
                          //     //     onPressed: (){},
                          //     //     icon: Icon(Icons.delete_forever_rounded)
                          //     // ),
                          //   ],
                          // ),
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "Email: ${documentSnapshot['emailId']}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Phone Number : ${documentSnapshot['phoneNumber']}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Location : ${documentSnapshot['location']}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        _update(documentSnapshot);
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        _delete(documentSnapshot.id);
                                      },
                                      icon: Icon(Icons.delete_forever_rounded)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
