import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(home: ProfilePage(),)
  );
}

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  TextEditingController adisoyadi = new TextEditingController();
  TextEditingController telno = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController dogumtarihi = new TextEditingController();
  TextEditingController adres = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(210),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                padding: const EdgeInsets.only(left: 15),
              ),
              backgroundColor: Color(0xFFE5E5E5),
              automaticallyImplyLeading: true,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              title: const Text(
                "Profil",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.black),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.settings),
                          label: Text('Profili Düzenle'),
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          )),
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.logout),
                          label: Text('Çıkış Yap'),
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          )),
                    ),
                  ],
                ),
              ],
              flexibleSpace: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: double.infinity,
                child: Column(children: <Widget>[
                  Padding(padding: const EdgeInsets.all(35.0)),
                  CircleAvatar(
                    radius: 50,
                    child: Image.asset(
                      'assets/images/profile/first.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Jenny Wilson",
                    style: TextStyle(fontSize: 20),
                  ),
                ]),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
            ),
          ),
          backgroundColor: Color(0xFFE5E5E5),
          body: Container(
            padding: EdgeInsets.all(22),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: adisoyadi,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[350],
                          hintText: "Adı Soyadı"
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: telno,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[350],
                          hintText: "Telefon Numarası"
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[350],
                          hintText: "E-Mail"
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: dogumtarihi,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[350],
                          hintText: "Doğum Tarihi   "
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: adres,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[350],
                          hintText: "Adres"
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(onPressed: (){
                      Map<String,dynamic> data= {"field1":adisoyadi.text,"field2":telno.text,"field3":email,"field4":dogumtarihi,"field5":adres.text,};
                      FirebaseFirestore.instance.collection("ProfileDetails").add(data);
                    },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.purple,
                        elevation: 20,
                        minimumSize: Size(84, 34),
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                        child: Text("Save"),
                    )
                  ],
                ),
              ),
            ),
          )
        ),
        onWillPop: () async {
          return false;
        });
  }
}
