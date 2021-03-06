import 'package:crypto_shadow/ui/common/gradient_appbar.dart';
import 'package:crypto_shadow/ui/detail/detail_page.dart';
import 'package:crypto_shadow/ui/news/news_page.dart';
import 'package:crypto_shadow/ui/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'home_page_body.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;
import 'dart:math' as Math;

class HomePage extends StatefulWidget {
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {

  //https://cryptodonate.io/101296421651150539388
  AnimationController _controller;

  @override
  void initState(){
    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  static const List<IconData> icons = const [Icons.settings, Icons.view_list, Icons.payment];
  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new Column(
        children: <Widget>[
          new GradientAppBar("CryptoShadow"),
          new HomePageBody(),
        ],
      ),
      
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index){
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
                scale: new CurvedAnimation(
                    parent: _controller,
                    curve: new Interval(
                        0.0,
                        1.0 - index / icons.length / 2.0,
                        curve: Curves.easeOut
                    ),
                ),
                child: new FloatingActionButton(
                  backgroundColor: Theme.Colors.colorBlue,
                  mini: true,
                  child: new Icon(
                      icons[index],
                      color: Theme.Colors.colorWhite,
                  ),
                  heroTag: "hero-fab-"+index.toString(),

                  onPressed: (){
                    if(index == 0){
                      _controller.reverse();
                      Navigator.of(context).push(
                        new PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new SettingsPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                          new FadeTransition(opacity: animation, child: child),
                        ),
                      );
                    }
                    else if(index == 1){
                      _controller.reverse();
                      Navigator.of(context).push(
                        new PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new NewsPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                          new FadeTransition(opacity: animation, child: child),
                        ),
                      );
                    }
                    else if(index == 2){
                      _controller.reverse();
                      Navigator.of(context).push(
                        new PageRouteBuilder(

                          pageBuilder: (_, __, ___) => new WebviewScaffold(
                            url: "https://cryptodonate.io/101296421651150539388",
                            appBar: new AppBar(

                              centerTitle: true,
                              title: new Text("Hugo EXTRAT", style:const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36.0),
                              ),
                              backgroundColor: Theme.Colors.appBarGradientStart,
                            ),
                          ),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                          new FadeTransition(opacity: animation, child: child),
                        ),
                      );
                    }
                  },
                ),
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child){
                  return new Transform(
                    transform: new Matrix4.rotationZ(_controller.value * 0.5 * Math.PI),
                    alignment: FractionalOffset.center,
                    child: new Icon(_controller.isDismissed ? Icons.add : Icons.close)
                  );
                },
            ),
            onPressed: (){
              if(_controller.isDismissed){
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
      )
    );
  }
}