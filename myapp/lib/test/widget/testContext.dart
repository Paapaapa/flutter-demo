import 'package:flutter/material.dart';

// 测试context上下文
class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context测试"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在Widget树中向上查找最近的父级`Scaffold` widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType();
          // 直接返回 AppBar的title， 此处实际上是Text("Context测试")
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}

// 测试获取State对象
class TestContextWidget extends StatelessWidget {
  //定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey, //设置key
      appBar: AppBar(
        title: Text("子树中获取State对象"),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              // 获取父级最近的Scaffold对应的ScaffoldState对象
              // 第一种，findAncestorStateOfType
              // ScaffoldState _state = context.findAncestorStateOfType();
              // 第二种，直接通过of静态方法来获取ScaffoldState
              // ScaffoldState _state=Scaffold.of(context);
              //调用ScaffoldState的showSnackBar来弹出SnackBar
//              _state.showSnackBar(
//                SnackBar(
//                  content: Text("我是SnackBar"),
//                ),
//              );
              // 第三种，通过GlobalKey来获取
              // GlobalKey是Flutter提供的一种在整个APP中引用element的机制。
              // 如果一个widget设置了GlobalKey，那么我们便可以通过globalKey.currentWidget
              // 获得该widget对象、globalKey.currentElement来获得widget对应的element对象，
              // 如果当前widget是StatefulWidget，则可以通过globalKey.currentState
              // 来获得该widget对应的state对象
              _globalKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("我是SnackBar"),
                ),
              );
            },
            child: Text("显示SnackBar"),
          );
        }),
      ),
    );
  }
}
