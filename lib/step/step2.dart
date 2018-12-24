//第2步: 使用外部包(package)


import 'package:flutter/material.dart';
//和大多数语言的导入对应包的操作差不多 使用import
import 'package:english_words/english_words.dart';

//本示例创建一个Material APP。Material是一种标准的移动端和web端的视觉设计语言。 Flutter提供了一套丰富的Material widgets。
//main函数使用了(=>)符号, 这是Dart中单行函数或方法的简写。
void main() => runApp(new MyApp());

//该应用程序继承了 StatelessWidget，这将会使应用本身也成为一个widget。 在Flutter中，大多数东西都是widget，包括对齐(alignment)、填充(padding)和布局(layout)
class MyApp extends StatelessWidget {

  //widget的主要工作是提供一个build()方法来描述如何根据其他较低级别的widget来显示自己。
  //本示例中的body的widget树中包含了一个Center widget, Center widget又包含一个 Text 子widget。 Center widget可以将其子widget树对其到屏幕中心。
  @override
  Widget build(BuildContext context) {

    //创建一个wordpair对象，用其生成的单词替换hello word
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      //Scaffold 是 Material library 中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。widget树可以很复杂。
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          //驼峰命名法” (称为 “upper camel case” 或 “Pascal case” ), 表示字符串中的每个单词（包括第一个单词）都以大写字母开头。所以，“uppercamelcase” 变成 “UpperCamelCase”
          //child: new Text('Hello World'),
          child: new Text(wordPair.asPascalCase),
        ),
      ),
    );
  }
}

