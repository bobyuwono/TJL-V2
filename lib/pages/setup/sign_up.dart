import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/pages/setup/login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
            onPressed: signUp,
            child: Text('Sign Up'), 
          )
        ],
      ) ,
      ),
    );
  }

  void signUp() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        //FirebaseUser user = 
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: _password);
       // user.sendEmailVerification();  
           //display for the user that we sent an email.
        //Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
        }
      catch(e){
        print(e.message);
      }
      
    }
  }
}