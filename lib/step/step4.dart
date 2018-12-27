//4步: 创建一个无限滚动ListView
//在这一步中，您将扩展（继承）RandomWordsState类，以生成并显示单词对列表。
//当用户滚动时，ListView中显示的列表将无限增长。
//ListView的builder工厂构造函数允许您按需建立一个懒加载的列表视图。

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

//  Widget build(BuildContext context) {
//    //2创建一个wordpair对象，用其生成的单词替换hello word
//    //3删除此行
////    final wordPair = new WordPair.randomom();
//    //3注释掉原来的生成单词的代码 使用我们在第3步新建的
//    return new MaterialApp(
//      title: 'Welcome to Flutter',
//      //1Scaffold 是 Material library 中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。widget树可以很复杂。
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
//          //2驼峰命名法” (称为 “upper camel case” 或 “Pascal case” ), 表示字符串中的每个单词（包括第一个单词）都以大写字母开头。所以，“uppercamelcase” 变成 “UpperCamelCase”
//          //child: new Text('Hello World'),
//          //3这里改为使用第3步生成的代码获得单词
//          child: new RandomWords(),
//        ),
//      ),
//    );
//  }
//4更新MyApp的build方法。从MyApp中删除Scaffold和AppBar实例。
//4这些将由RandomWordsState管理，这使得用户在下一步中从一个屏幕导航到另一个屏幕时， 可以更轻松地更改导航栏中的的路由名称。
//4用下面的代码替换最初的build方法(上面注释的掉的代码)：
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
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

  //4向RandomWordsState类中添加一个_suggestions列表以保存建议的单词对。
  //4该变量以下划线（_）开头，在Dart语言中使用下划线前缀标识符，会强制其变成私有的。
  //4另外，添加一个biggerFont变量来增大字体大小
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  //3在添加状态类后，IDE会提示该类缺少build方法。
  //3接下来，您将添加一个基本的build方法，该方法通过将生成单词对的代码从MyApp移动到RandomWordsState来生成单词对。
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //4更新RandomWordsState的build方法以使用_buildSuggestions()，而不是直接调用单词生成库。
    //4停用下面两行
    //final wordPair = new WordPair.random();
    //return new Text(wordPair.asPascalCase);

    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }


  //4向RandomWordsState类添加一个 _buildSuggestions() 函数. 此方法构建显示建议单词对的ListView。
  //4ListView类提供了一个builder属性，itemBuilder 值是一个匿名回调函数， 接受两个参数- BuildContext和行迭代器i。
  //4迭代器从0开始， 每调用一次该函数，i就会自增1，对于每个建议的单词对都会执行一次。
  //4该模型允许建议的单词对列表在用户滚动时无限增长。
  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        //4对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        //4在偶数行，该函数会为单词对添加一个ListTile row.
        //4在奇数行，该行书湖添加一个分割线widget，来分隔相邻的词对。
        //4注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context, i) {
          //4在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();

          //4语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          //4如果是建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // 4...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  //4对于每一个单词对，_buildSuggestions函数都会调用一次_buildRow。
  //4这个函数在ListTile中显示每个新词对，这使您在下一步中可以生成更漂亮的显示行
  //4在RandomWordsState中添加一个_buildRow函数 :
  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

}