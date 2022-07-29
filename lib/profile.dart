import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users/users_list.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({Key? key}) : super(key: key);

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phnnm = TextEditingController();
  TextEditingController loc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom:10),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your Name",
                  labelText: "Name"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom:10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your email",
                    labelText: "Email"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom:10),
              child: TextFormField(
                controller: loc,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Location",
                    labelText: "Location"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom:10),
              child: TextFormField(
                controller: phnnm,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your PhoneNumber",
                    labelText: "PhoneNumber"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom:10),
                  child: ElevatedButton(
                    onPressed: (){

                      CollectionReference users = FirebaseFirestore.instance.collection('users');
                      Future<void> addUser() {
                        return users
                            .add({
                          'userName': name.text.toString(),
                          'phoneNumber': phnnm.text.toString(),
                          'location': loc.text.toString() ,
                          'emailId':email.text.toString()
                        }).then((value) => print("User Added"))
                            .catchError((error) => print("Failed to add user: $error"));
                      }
                      addUser();
                      name.clear();
                      phnnm.clear();
                      loc.clear();
                      email.clear();

                    },
                    child: Text("Submit"),
                  ),
                ),
                Container(
                  child: OutlinedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UseresList()));
                    },
                    child: Text("Users"),
                  ),
                ),
                Container(
                  child: OutlinedButton(
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => UseresList()));
                    },
                    child: Text("Update"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
