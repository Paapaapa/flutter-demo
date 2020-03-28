import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:camera/camera.dart';
import 'package:english_words/english_words.dart';
import 'package:json_model/json_model.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:myapp/test/function/testPopScope.dart';
import 'test/first/testRoute.dart';
import 'test/widget/testState.dart';
import 'test/widget/testContext.dart';
import 'test/widget/testManageState.dart';
import 'test/scrollview/testController.dart';
import 'test/scrollview/testNotification.dart';
import 'test/event/testGesture.dart';
import 'test/animation/testBasicAnimation.dart';
import 'test/animation/testRouteAnimation.dart';
import 'test/animation/testHero.dart';
import 'test/animation/testStaggerAnimation.dart';
import 'test/animation/testAnimatedSwitcher.dart';
import 'test/animation/testAnimationTransition.dart';
import 'test/customcomponents/TestCombine.dart';
import 'test/customcomponents/TestCustomPaint.dart';
import 'test/customcomponents/TestGradientCircularProgressIndicator.dart';
import 'test/file/TestBasicFile.dart';
import 'test/file/TestHttpClient.dart';
import 'test/file/TestDio.dart';
import 'test/file/TestFileChunk.dart';
import 'test/file/TestWebSocket.dart';
import 'test/plugin/TestCamera.dart';

// 全局变量,可用摄像头列表
List cameras = [];

// 加载静态文件-文本
Future<String> loadAsset() async {
  var result = await rootBundle.loadString('assets/test.json');
  print(result);
  return result;
}

// 入口main函数
void main() {
  // 获取可用摄像头列表，cameras为全局变量
  // cameras = await availableCameras();
  runApp(MyApp());
}

// 测试文件分块下载
//main() async{
//  var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
//  var savePath = "./test555";
//  await downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
//    if (total != -1) {
//      print("${(received / total * 100).floor()}%");
//    }
//  });
//}

// 测试JSON Model化
//void main() {
//  run(['src=jsons']);  //run
//}

class MyApp extends StatelessWidget {
  // 根控件
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      localizationsDelegates: [
//        // 本地化的代理类
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
//      ],
//      supportedLocales: [
//        const Locale('en', 'US'), // 美国英语
//        const Locale('zh', 'CN'), // 中文简体
//        //其它Locales
//      ],
      title: 'Flutter Demo',
      initialRoute: "/",
      //名为"/"的路由作为应用的home(首页)
      // 主题
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //注册路由表
      routes: {
        // 测试资源加载
        "test_asset_image": (context) => TestAssetImageWidget(),
        // 路由传参-在路由表中传参
        "first_page": (context) =>
            TipRoute(text: ModalRoute.of(context).settings.arguments),
        // 测试命名路由传参
        "new_page": (context) => NewRoute(),
        //注册首页路由
         "/": (context) => MyHomePage(title: 'home page'),
        // 2.1.计数器示例
        // "/": (context) => TestStateWidget(), // 3.1.widget简介-State生命周期
        // "/": (context) => TestContextWidget(), // 3.1.widget简介-context,在widget树中获取State对象
        // "/": (context) => ParentWidgetC(),// 3.2.状态管理
        // "/": (context) => ScrollControllerTestRoute(),// 6.6.滚动监听及控制-ScrollController
        // "/": (context) => ScrollNotificationTestRoute(),// 6.6.滚动监听及控制-NotificationListener
        // "/": (context) => WillPopScopeTestRoute(),// 7.1.导航返回拦截
        // "/": (context) => GestureDetectorTestRoute(),// 8.2.手势识别-单击/双击/长按
        // "/": (context) => TestDrag(),// 8.2.手势识别-拖动
        // "/": (context) => TestDragVertical(),// 8.2.手势识别-单一方向拖动
        // "/": (context) => ScaleTestRoute(),// 8.2.手势识别-缩放
        // "/": (context) => GestureRecognizerTestRoute(),// 8.2.手势识别-GestureRecognizer
        // "/": (context) => BothDirectionTestRoute(),// 8.2.手势识别-手势竞争
        // "/": (context) => GestureConflictTestRoute(),// 8.2.手势识别-手势冲突
        // "/": (context) => ScaleAnimationRoute(),// 9.1.动画基本结构与状态监听-基本结构
        // "/": (context) => ScaleAnimationRoute1(),// 9.1.动画基本结构与状态监听-AnimatedWidget简化
        // "/": (context) => HeroAnimationRoute(),// 9.4.Hero动画
        // "/": (context) => StaggerRoute(),// 9.5.交织动画
        // "/": (context) => AnimatedSwitcherCounterRoute(),// 9.6.通用切换动画组件
        // "/": (context) => AnimatedWidgetsTest(),// 9.7.动画过渡组件
        // "/": (context) => GradientButtonRoute(),// 10.2.组合现有组件
        // "/": (context) => TurnBoxRoute(),// 10.3.组合实例：TurnBox
        // "/": (context) => CustomPaintRoute(),// 10.4.自绘组件 （CustomPaint与Canvas）
        // "/": (context) => GradientCircularProgressRoute(),// 10.5.自绘实例：圆形背景渐变进度条
        // "/": (context) => FileOperationRoute(),// 11.1.文件操作
        // "/": (context) => HttpTestRoute(),// 11.2.Http请求-HttpClient
        // "/": (context) => FutureBuilderRoute(),// 11.2.Http请求-Dio库
        // "/": (context) => WebSocketRoute(),// 11.5.使用WebSockets
        // "/": (context) => CameraExampleHome(), // 12.6.Texture
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
          print(routeName);
          return NewRoute();
        });
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'), // 不可与initialRoute同时用
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context).settings.arguments;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text('New Route'),
      ),
      body: Center(
        child: Text('This is new route'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text('Open new route'),
              textColor: Colors.blue,
              onPressed: () {
                // 1.导肮至新路由
//                Navigator.push(context,MaterialPageRoute(builder:(context){
//                  return NewRoute();
//                }));
                // 使用PageRouteBuilder自定义路由切换
//                Navigator.push(
//                  context,
//                  PageRouteBuilder(
//                    transitionDuration:
//                        Duration(milliseconds: 500), //动画时间为500毫秒
//                    pageBuilder: (BuildContext context, Animation animation,
//                        Animation secondaryAnimation) {
//                      return new FadeTransition(
//                        //使用渐隐渐入过渡,
//                        opacity: animation,
//                        child: NewRoute(), //路由B
//                      );
//                    },
//                  ),
//                );
                // 使用继承PageRoute的自定义路由类切换
                Navigator.push(context, FadeRoute(builder: (context) {
                  return NewRoute();
                }));

                // 2.命名路由传参
                // Navigator.pushNamed(context, "new_page", arguments: 'hi');
                // 命名路由
//                Navigator.pushNamed(context, "first_page", arguments: 'hi');

                // 测试资源管理-json文件
                loadAsset();
              },
            ),
            RandomWordsWidget(),
            // TestAssetImageWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

// 测试包管理
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

// 测试资源管理-加载静态资源图片
class TestAssetImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取imageProvider
//    return new DecoratedBox(
//      decoration: new BoxDecoration(
//        image: new DecorationImage(
//          image: new AssetImage('assets/web.jpg'),
//        ),
//      ),
//    );
    // 获取图片控件
    return Image.asset('assets/web.jpg');
  }
}
