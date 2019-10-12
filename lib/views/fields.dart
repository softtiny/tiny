import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config.dart';
class linkData {
  String pythonurl = domain;
  String vlcurl = vlcDomain;
  String l_img = imgDomain;
  String l_cateId=cateId;
}

class Field extends StatefulWidget {
  const Field({ Key key }) : super(key: key);

  static const String routeName = '/field';

  @override
  FieldState createState() => FieldState();
}

class FieldState extends State<Field> {
  linkData urls = linkData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('url fields'),
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
                      labelText: 'python url',
                    ),
                    onSaved:(String value){
                      urls.pythonurl=value;
                    },
                  ),
                  const SizedBox(height: 24.0,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled:true,
                      labelText: 'vlc url',
                    ),
                    onSaved:(String value){
                      urls.vlcurl=value;
                    },
                  ),
                  const SizedBox(height: 24.0,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled:true,
                      labelText: 'img url',
                    ),
                    onSaved:(String value){
                      urls.l_img=value;
                    },
                  ),
                  const SizedBox(height: 24.0,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled:true,
                      labelText: 'cateid',
                    ),
                    onSaved:(String value){
                      urls.l_cateId=value;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('SUBMIT'),
                      onPressed: (){
                        final FormState form = _formKey.currentState;
                        form.save();
                        print(urls.pythonurl);
                        setDomain(urls.pythonurl);
                        setVlc(urls.vlcurl);
                        setImg(urls.l_img);
                        setCateId(urls.l_cateId);
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('pythonurl:http://10.220.8.242:8000/'),
                      onPressed: (){
                        setDomain('http://10.220.8.242:8000/');
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('pythonurl:http://192.168.0.104:8000/'),
                      onPressed: (){
                        setDomain('http://192.168.0.104:8000/');
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('setImg:http://10.220.8.242:8000/'),
                      onPressed: (){
                        setImg('http://10.220.8.242:8000/');
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('setImg:http://192.168.0.104:8000/'),
                      onPressed: (){
                        setImg('http://192.168.0.104:8000/');
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('setVlc:192.168.0.104/share/'),
                      onPressed: (){
                        setVlc('192.168.0.104/share/');
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('smb://10.220.8.242/share/'),
                      onPressed: (){
                        setVlc('10.220.8.242/share/');
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('setCateId:7'),
                      onPressed: (){
                        setCateId('7');
                      },
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