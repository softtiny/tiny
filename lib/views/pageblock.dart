import 'package:flutter/material.dart';

List<Widget> _builderItem(){
  return [
    Container(
      child:Center(
        child:Text("page1"),
      ),
    ),
    Container(
      child:Center(
        child:Text("page2"),
      ),
    ),
    Container(
      child:GridView.count(
        crossAxisCount: 3,
        children: <Widget>[
          Image.network(
            'https://picsum.photos/id/849/320/320',
          ),
          Image.network(
            'https://picsum.photos/id/849/320/320',
          ),
          Image.network(
            'https://picsum.photos/id/849/320/320',
          ),
          Image.network(
            'https://picsum.photos/id/849/320/320',
          ),
          Image.network(
            'https://picsum.photos/id/849/320/320',
          ),
          Image.network(
            'https://picsum.photos/id/849/320/320',
          ),
          Image.network(
            'https://picsum.photos/id/849/320/320',
          ),
          Image.network(
            'https://picsum.photos/id/849/320/320',
          ),
          Image.network(
            'http://321tips.j19o.cn:8899/849/320/320',
          ),
          Image.network(
            'http://321tips.j19o.cn:8899/849/320/320',
          ),
          Center(
            child:Text('1324'),
          ),
          Center(
            child: RaisedButton(
              onPressed: (){},
              color: const Color.fromARGB(255, 66, 165, 245),
              child: const Text('play'),
            ),
          ),
        ],
      ),
    ),
    Container(
      child:Center(
        child:Image.network(
          'https://picsum.photos/id/849/320/320',
        ),
      ),
    ),
  ];
}

class PageblockState extends State<Pageblock>{
  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar:AppBar(
        title: const Text("pageblock"),
      ),
      body:PageView(
        children: _builderItem(),
        scrollDirection:Axis.horizontal,
      ),
    );
  }
}

class Pageblock extends StatefulWidget{
  const Pageblock({Key key}):super(key:key);
  @override
  PageblockState createState() => PageblockState();
}