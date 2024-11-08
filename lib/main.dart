import 'package:flutter/material.dart';
import 'package:linux_do/service/NetworkService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'mi',
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TopicItem> _itemList = [];

  @override
  void initState() {
    super.initState();
    _loadResource();
  }

  Future<void> _loadResource() async {
    var latest = await networkService.latest();
    setState(() {
      _itemList = latest.topic_list.topics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
            itemBuilder: (c, i) {
              return SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Text(
                      '${_itemList[i].title}',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'thin',
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: _itemList.length),
      ),
    );
  }
}
