//第3步: 添加一个 有状态的部件（Stateful widget）(注意:代码中注释开头的数字代表第几步添加的注释)
//Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
//Stateful widgets 持有的状态可能在widget生命周期中发生变化. 实现一个 stateful widget 至少需要两个类:
//一个 StatefulWidget类。
//一个 State类。 StatefulWidget类本身是不变的，但是 State类在widget生命周期中始终存在.
//在这一步中，您将添加一个有状态的widget-RandomWords，它创建其State类RandomWordsState。State类将最终为widget维护建议的和喜欢的单词对。

import 'package:flutter/material.dart';

//和大多数语言的导入对应包的操作差不多 使用import
import 'package:english_words/english_words.dart';
import 'package:learn_flutter/main.dart';

//1本示例创建一个Material APP。Material是一种标准的移动端和web端的视觉设计语言。 Flutter提供了一套丰富的Material widgets。
//1main函数使用了(=>)符号, 这是Dart中单行函数或方法的简写。
void main() => runApp(new MyApp());

//1该应用程序继承了 StatelessWidget，这将会使应用本身也成为一个widget。 在Flutter中，大多数东西都是widget，包括对齐(alignment)、填充(padding)和布局(layout)
class MyApp extends StatelessWidget {
  //1widget的主要工作是提供一个build()方法来描述如何根据其他较低级别的widget来显示自己。
  //1本示例中的body的widget树中包含了一个Center widget, Center widget又包含一个 Text 子widget。 Center widget可以将其子widget树对其到屏幕中心。
  @override
  Widget build(BuildContext context) {
    //2创建一个wordpair对象，用其生成的单词替换hello word
    //3删除此行
//    final wordPair = new WordPair.randomom();
   //3注释掉原来的生成单词的代码 使用我们在第3步新建的
    return new MaterialApp(
      title: 'Welcome to Flutter',
      //1Scaffold 是 Material library 中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。widget树可以很复杂。
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          //2驼峰命名法” (称为 “upper camel case” 或 “Pascal case” ), 表示字符串中的每个单词（包括第一个单词）都以大写字母开头。所以，“uppercamelcase” 变成 “UpperCamelCase”
          //child: new Text('Hello World'),
          //3这里改为使用第3步生成的代码获得单词
          child: new RandomWords(),
        ),
      ),
    );
  }
}

//3添加有状态的 RandomWords widget 到 main.dart。
//3它也可以在MyApp之外的文件的任何位置使用，但是本示例将它放到了文件的底部。
//3RandomWords widget除了创建State类之外几乎没有其他任何东西
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}
//3添加 RandomWordsState 类.该应用程序的大部分代码都在该类中， 该类持有RandomWords widget的状态。
//3这个类将保存随着用户滚动而无限增长的生成的单词对， 以及喜欢的单词对，用户通过重复点击心形 ❤️ 图标来将它们从列表中添加或删除。
class RandomWordsState extends State<RandomWords> {

  //3在添加状态类后，IDE会提示该类缺少build方法。
  //3接下来，您将添加一个基本的build方法，该方法通过将生成单词对的代码从MyApp移动到RandomWordsState来生成单词对。
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase);
  }

}
