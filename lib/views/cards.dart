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

class TravelDestinationContent extends StatelessWidget {
  const TravelDestinationContent({ Key key, @required this.destination }):assert(destination != null),
  super(key:key);
  final TravelDestination destination;
  @override
  Widget build(BuildContext context){
    print(imgDomain+destination.imgs[0]['rel_path']);
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.headline.copyWith(color: Colors.white);
    final List<Widget> children = <Widget>[
      SizedBox(
        height: 184.0,
        child:Stack(
          children:<Widget>[
            Positioned.fill(
              child: Ink.image(
                image:CachedNetworkImageProvider(imgDomain+destination.imgs[0]['rel_path']),
                fit:BoxFit.cover,
                child: Container(),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child:GestureDetector(
                onTap: (){
                  TUBEtool.openvlc(destination.rel_path);
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    destination.title,
                  ),
                ),
              ),
              
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child:DefaultTextStyle(
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: titleStyle,
          child: Text(
                  destination.duration,
          ),
        ),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}


class TravelDestinationItem extends StatelessWidget {
  const TravelDestinationItem({ Key key,@required this.destination }): assert(destination !=null),
  super(key:key);
  final TravelDestination destination;

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const double height = 338.0;

  @override
  Widget build(BuildContext context){
    return SafeArea(
      top:false,
      bottom: false,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height,
              child:Card(
                // This ensures that the Card's children are clipped correctly.
                clipBehavior: Clip.antiAlias,
                child:TravelDestinationContent(destination: destination),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cards extends StatefulWidget {
  const Cards( {Key key }):super(key:key);
  static const String routeName = '/cards';
  @override
  CardsState createState () => CardsState();
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
  destinationList=_genList(data);
}
class CardsState extends State<Cards>{
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
      return Scrollbar(
              child: ListView(
                padding:const EdgeInsets.only(top:8.0,left:8.0,right:8.0),
                children:data.map<Widget>((TravelDestination destination){
                  TravelDestinationItem child = TravelDestinationItem(destination: destination);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child:child,
                  );
                }).toList(),
              ),
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
        return null;
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards list'),
      ),
      body: fbuilder,
    );
  }
}