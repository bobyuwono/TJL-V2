import 'package:flutter/material.dart';
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

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
List<Item> destinasi = List();
  Item item;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("", "","","","","","");
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.  
    itemRef = database.reference().child('destinasi');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      destinasi.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  _onEntryChanged(Event event) {
    var old = destinasi.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      destinasi[destinasi.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('input destinasi disini pal'),
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
                        initialValue: "", 
                        onSaved: (val) => item.nama = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    
                    ListTile(
                      leading: Icon(Icons.contact_mail),
                      title: TextFormField(
                        initialValue: '',
                        onSaved: (val) => item.rating = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => item.kota = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contact_phone),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => item.maplink = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contact_phone),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => item.img = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => item.deskripsi = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => item.harga = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        handleSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(destinasi[index].nama),
                  subtitle: Text(destinasi[index].rating, ),
                  

                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
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


class Item {
  String key;
  String nama;
  String rating;
  String kota;
  String maplink;
  String img;
  String deskripsi;
  String harga;

  Item(this.nama, this.rating,this.kota, this.maplink,this.img,this.deskripsi,this.harga);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        nama = snapshot.value["nama"],
        rating = snapshot.value["rating"],
        kota = snapshot.value["kota"],
        maplink = snapshot.value["maplink"],
        img=snapshot.value["img"],
        deskripsi = snapshot.value["deskripsi"],
        harga = snapshot.value["harga"];


  toJson() {
    return {
      "nama": nama,
      "rating": rating,
      "kota": kota,
      "maplink": maplink,
      "img": img,
      "deskripsi": deskripsi,
      "harga": harga,
    };
  }
}
