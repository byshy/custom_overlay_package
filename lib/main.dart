import 'package:flutter/material.dart';

import 'list_item.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (_, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final List<Model> models = List.generate(
    10,
    (index) => Model(
      id: index,
      title: 'title #$index',
      subTitle: 'subTitle #$index',
    ),
  );

  AnimationController _controller;
  Animation<double> _animation;

  final Duration _animationDuration = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Overlay'),
      ),
      body: GestureDetector(
        onTap: () => print('main GestureDetector tapped'),
        onVerticalDragDown: (_) => print('main GestureDetector onVerticalDragDown'),
        child: ListView.separated(
          itemBuilder: (_, index) => ListItem(
            onTap: () => print('ListItem #$index tapped'),
            model: models[index],
            controller: _controller,
            animation: _animation,
          ),
          separatorBuilder: (_, index) => const SizedBox(height: 10),
          itemCount: models.length,
        ),
      ),
    );
  }
}
