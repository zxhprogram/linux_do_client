import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../config/GlobalConfig.dart';
import '../service/NetworkService.dart';

class ItemListPage extends StatefulWidget {
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<Item> _itemList = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadResource();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadResource() async {
    var latest = await networkService.latest();
    setState(() {
      _itemList = latest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          print(constraints);
          return Column(
            children: [
              Container(
                height: 100,
                color: Colors.pinkAccent,
              ),
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (c, i) {
                      return TopicContentItemUi(constraints, i, _itemList);
                    },
                    itemCount: _itemList.length),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TopicContentItemUi extends StatelessWidget {
  final BoxConstraints constraints;
  final int index;
  final List<Item> itemList;

  TopicContentItemUi(this.constraints, this.index, this.itemList);

  @override
  Widget build(BuildContext context) {
    var i = index;
    var maxWidth = constraints.maxWidth - avatarSize;
    print(maxWidth);
    return Center(
      child: Container(
        width: maxWidth,
        padding: EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Tooltip(
                message: itemList[i].authorName == null
                    ? ''
                    : itemList[i].authorName!,
                verticalOffset: -30,
                margin: EdgeInsets.only(left: 60),
                child: itemList[i].avatar!.contains('size')
                    ? Container(
                        height: avatarSize / 1.0,
                        width: avatarSize / 1.0,
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            itemList[i].authorName!.substring(0, 1),
                            style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 30,
                                foreground: Paint()..color = Colors.white),
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        height: avatarSize / 1.0,
                        width: avatarSize / 1.0,
                        imageUrl: itemList[i].avatar!,
                        placeholder: (c, u) => CircularProgressIndicator(),
                        errorWidget: (c, u, e) {
                          return Icon(Icons.account_circle);
                        },
                      ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: maxWidth - 10,
                  child: Text(
                    '${itemList[i].title}',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'normal',
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  // constraints: BoxConstraints(maxWidth: maxWidth - 10),
                  width: maxWidth - 10,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        child: Text(
                          itemList[i].lastPosterName == null
                              ? ''
                              : itemList[i].lastPosterName!,
                          style: TextStyle(
                              fontFamily: 'normal',
                              overflow: TextOverflow.fade),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        width: maxWidth - 155,
                        child: Text(
                          ':这是测试数据，请你查收，样式展示22222222222222',
                          style: TextStyle(
                              fontFamily: 'normal',
                              overflow: TextOverflow.clip),
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr, // 设置文本的方向
    );
    textPainter.layout(); // 布局文本，计算宽度和高度
    var r = textPainter.size.width;
    print(r);
    return r; // 获取宽度
  }
}
