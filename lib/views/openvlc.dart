import 'dart:async';

import 'package:flutter/material.dart';

import '../TUBEtool.dart';

class OpenVlc extends StatefulWidget {
  const OpenVlc({ Key key }) : super(key: key);

  static const String routeName = '/openvlc';

  @override
  OpenVlcState createState() => OpenVlcState();
}

class OpenVlcState extends State<OpenVlc> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int counter = 0;
  List<String> liststr = [
    'vlc://a.mp4',
    'vlc:smb://a.mp4',
    'smb://a.mp4',
    'smb://root@10.220.8.242/a.mp4',
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('openvlc fields'),
      ),
      body:SafeArea(
        top:false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24.0,),
                  const SizedBox(height: 24.0,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled:true,
                      labelText: 'adcc',
                    ),
                    onSaved:(String value){
                      TUBEtool.pageopenvlc(value);
                    },
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('SUBMIT'),
                      onPressed: (){
                        final FormState form = _formKey.currentState;
                        form.save();
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        counter++; 
                      });
                    },
                    tooltip: 'add',
                    icon: Icon(Icons.add_call),
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        counter--; 
                      });
                    },
                    tooltip: 'minus',
                    icon: Icon(Icons.minimize),
                  ),
                  GestureDetector(
                    // When the child is tapped, show a snackbar.
                    onTap: () {
                      TUBEtool.pageopenvlc(liststr[counter]);
                    },
                    // The custom button
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('1 Button'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}