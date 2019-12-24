import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:hello_flutter/model/app_state_model.dart';

import './route/route.dart';
import './config.dart';
import './DBConf.dart';
void main() => runApp(TinyApp());

typedef UpdateUrlFetcher = Future<String> Function();

class TinyApp extends StatefulWidget {
  const TinyApp({
    Key key,
    this.updateUrlFetcher,
    this.enablePerformanceOverlay = true,
    this.enableRasterCacheImagesCheckerboard = true,
    this.enableOffscreenLayersCheckerboard = true,
    this.onSendFeedback,
    this.testMode = false,
  }) : super(key: key);
  final UpdateUrlFetcher updateUrlFetcher;
  final bool enablePerformanceOverlay;
  final bool enableRasterCacheImagesCheckerboard;
  final bool enableOffscreenLayersCheckerboard;
  final VoidCallback onSendFeedback;
  final bool testMode;

  @override
  _TinyAppState createState() => _TinyAppState();
}

class _TinyAppState extends State<TinyApp> {
  AppStateModel model;

  @override
  void initState() {
    super.initState();
    model = AppStateModel();
  }
  @override
  Widget build(BuildContext context){
    //todo
    DBConf.TCdbinit();
    return ScopedModel<AppStateModel>(
      model: model,
      child: MaterialApp(
        routes: route,
        builder: (BuildContext context, Widget child){
          return child;
        },
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    http.Client httpClient = http.Client();
    httpClient.get('http://qq.com/sdkd');
  }

  void _minusCounter(){
    DBConf.TCconfs().then((res){
      dynamic item = res[3];
      setDomain(item['domain']);
      setVlc(item['vlc_domain']);
      setImg(item['img_domain']);
      setCateId(item['cate_id']);
      setVlcStart(item['vlc_start']);
    });
  }
  void _gofields(BuildContext context){
    Navigator.pushNamed(context, '/field');
  }
  void _gocards(BuildContext context){
    Navigator.pushNamed(context, '/cards');
  }
  void _golog(BuildContext context){
    Navigator.pushNamed(context, '/log');
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _minusCounter,
              child: const Text('Minus'),
            ),
            RaisedButton(
              onPressed: (){
                _golog(context);
              },
              child: const Text('go log'),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/demo');
              },
              child: const Text('go demo'),
            ),
            RaisedButton(
              onPressed: (){
                _gofields(context);
              },
              child: const Text('go fields'),
            ),
            RaisedButton(
              onPressed: (){
                _gocards(context);
              },
              child: const Text('go cards'),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/openvlc');
              },
              child: const Text('go openvlc'),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/datatable');
              },
              child: const Text('go data table'),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/pageblock');
              },
              child: const Text('go pageblock'),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/grids');
              },
              child: const Text('go grids'),
            ),
            Text(
              'pythonurl:${domain}|||',
            ),
            Text(
              'vlcDomain:${vlcDomain}|||',
            ),
            Text(
              'imgDomain:${imgDomain}|||',
            ),
            Text(
              'cateId:${cateId}||',
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
