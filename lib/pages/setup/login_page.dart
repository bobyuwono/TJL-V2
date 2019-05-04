import 'package:flutter/material.dart';
import 'package:login/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password; 
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: new Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        //implement key
        child:Column(children: <Widget>[
          TextFormField(
            validator:(input){
              if(input.isEmpty) { return'please type something';}
            } ,
            onSaved: (input)=> _email=input  ,
            decoration: InputDecoration(
              labelText: 'Email'
            ),
          ),
          TextFormField(
            validator:(input){
              if(input.isEmpty) { return'pleaseprovide a password';}
            } ,
            onSaved: (input)=> _password=input  ,
            decoration: InputDecoration(
              labelText: 'Password'
            ),
            obscureText: true,
          ),
          RaisedButton(
            onPressed: signIn,
            child: Text('Sign in'), 
          )
        ],
      ) ,
      ),
    );
  }

  Future<void>signIn() async{
    final formstate= _formKey.currentState;
    if(formstate.validate()){
      formstate.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(user: user)));// to do navigate to home
      }
      catch(e){
        print(e.message);
      }
      
    }
  }
}