import 'package:flutter/material.dart';

// 测试基本动画
class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  // 基本动画
//  initState() {
//    super.initState();
//    controller = new AnimationController(
//        duration: const Duration(seconds: 3), vsync: this);
//    //图片宽高从0变到300
//    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
//      ..addListener(() {
//        setState(()=>{});
//      });
//    //启动动画(正向执行)
//    controller.forward();
//  }

  // curve动画
  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Image.asset("assets/web.jpg",
          width: animation.value, height: animation.value),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: Image.asset(
        "assets/web.jpg",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

// 测试使用AnimatedWidget简化
class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  _ScaleAnimationRoute1State createState() => new _ScaleAnimationRoute1State();
}

class _ScaleAnimationRoute1State extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

//  initState() {
//    super.initState();
//    controller = new AnimationController(
//        duration: const Duration(seconds: 3), vsync: this);
//    //图片宽高从0变到300
//    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
//    //启动动画
//    controller.forward();
//  }

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画（正向）
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
//    return AnimatedImage(animation: animation);
    // 使用AnimatedBuilder重构
    return AnimatedBuilder(
      animation: animation,
      child: Image.asset("assets/web.jpg"),
      builder: (BuildContext ctx, Widget child) {
        return new Center(
          child: Container(
            height: animation.value,
            width: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
