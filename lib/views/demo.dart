import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Demo extends StatefulWidget {
  const Demo({ Key key }) : super(key: key);

  static const String routeName = '/demo';

  @override
  DemoState createState() => DemoState();
}

class DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('dome list'),
      ),
      body:Scrollbar(
        child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Ink.image(
                      image:CachedNetworkImageProvider('http://321tips.j19o.cn:8899/static/1.jpg'),
                      fit:BoxFit.cover,
                      child: Container(),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child:GestureDetector(
                      key: Key('kkk'),
                      onTap: (){
                        print("tap gd");
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'asdf',
                        ),
                      ),
                    ),
                    
                  ),
              ],
            ),
      ),
    );
  }
}