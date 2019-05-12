import 'package:flutter/material.dart';
import 'package:flutter_login_demo/models/profil.dart';
import 'package:flutter_login_demo/pages/page%20destinasi.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final List<String> _kelas = <String>['tourguide','traveler'];
  

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Profil profil;
  DatabaseReference profilRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profil = Profil("", "","","","");
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.  
    profilRef = database.reference().child('profil');
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      profilRef.push().set(profil.toJson());
    }
  }


  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB4C56C).withOpacity(0.5),
        title: Text('input profil disini pal'),
        actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: _signOut)
          ],
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'nama'
                        ),
                        initialValue: "", 
                        onSaved: (val) => profil.nama = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'nomor hp'
                        ),
                        initialValue: "", 
                        onSaved: (val) => profil.nomorhp = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'domisili'
                        ),
                        initialValue: "", 
                        onSaved: (val) => profil.kota = val,
                        validator: (val) => val == "" ? val : null,

                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'kelas'
                        ),
                        initialValue: "", 
                        onSaved: (val) => profil.kelas = val,
                        validator: (val) => val == "" ? val : null,

                      ),
                    ),
                     
                    
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
      
      
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            handleSubmit();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.navigate_next),
        )
    );
  }
}

