import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api.dart';
import '../config.dart';
import '../TUBEtool.dart';



class TravelDestination {
  const TravelDestination({
    @required this.rel_path,
    @required this.abs_path,
    @required this.title,
    @required this.duration,
    @required this.imgs,
  }) : assert(rel_path != null),
       assert(abs_path != null),
       assert(title != null),
       assert(duration != null),
       assert(imgs != null);
  final String rel_path;
  final String abs_path;
  final String title;
  final String duration;
  final List<dynamic> imgs;
}
class Grids extends StatefulWidget {
  const Grids( {Key key }):super(key:key);
  static const String routeName = '/grids';
  @override
  GridsState createState () => GridsState();
}
List<TravelDestination> _genList(response){
  List<TravelDestination> tmplist=[];
  print(response.length);
  for(int i=0;i<response.length;i++){
    var item = response[i];
    tmplist.add(TravelDestination(
      rel_path: item['rel_path'],
      abs_path: item['abs_path'],
      duration: item['duration'],
      title: item['title'],
      imgs: item['imgs'],
    ));
  }
  return tmplist;
}

List<TravelDestination> destinationList=[];
List<TravelDestination> setDestinationList(data){
  print("_genList");
  destinationList=_genList(data);
}
class GridsState extends State<Grids>{
  @override
  void initState(){
    super.initState();
  }
  Future<List<TravelDestination>> _getData() async{
    List<dynamic> response = await ApiCategoriesPkAllVideos(cateId);
    if(response == null){response=[];}
    List<TravelDestination> result = _genList(response);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget endw(data){
      return PageView(
        children: data.map<Widget>((TravelDestination destination){
          List<Widget> result = destination.imgs.map<Widget>((imgsrc){
            
            return Image.network(
              imgDomain+imgsrc['rel_path'],
            );
          }).toList();
          result.add(Center(
            child: RaisedButton(
              onPressed: (){
                TUBEtool.openvlc(destination.rel_path);
              },
              color: const Color.fromARGB(255, 66, 165, 245),
              child: const Text('play'),
            ),
          ));
          result.add(Center(
            child:Text(destination.duration),
          ));
          result.add(Center(
            child:Text(destination.title),
          ));
          return Container(
            child:GridView.count(
              crossAxisCount: 3,
              children: result,
            ),
          );
        }).toList(),
        scrollDirection: Axis.horizontal,
      );
    }
    FutureBuilder fbuilder = new FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if(destinationList.length!=0){
          return endw(destinationList);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError){
              return Text('Error: ${snapshot.error}');
            }
            return endw(snapshot.data);
        }
        return Text('TextNULL.');
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grids list'),
      ),
      body: fbuilder,
    );
  }
}