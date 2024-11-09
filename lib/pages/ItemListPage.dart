import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:linux_do/main.dart';
import 'package:provider/provider.dart';

import '../config/GlobalConfig.dart';
import '../config/ThemeConfig.dart';
import '../service/NetworkService.dart';
import '../state/GlobalStateProvider.dart';

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

class TopicContentItemUi extends StatefulWidget {
  final BoxConstraints constraints;
  final int index;
  final List<Item> itemList;

  TopicContentItemUi(this.constraints, this.index, this.itemList);

  @override
  State<TopicContentItemUi> createState() => _TopicContentItemUiState();
}

class _TopicContentItemUiState extends State<TopicContentItemUi> {
  int _currentHoverIndex = -100;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _loadResource();
  }

  Future<void> _loadResource() async {
    if (_count == 0) {
      int c = await networkService
          .topicCommentCount(widget.itemList[widget.index].id!);
      setState(() {
        _count = c;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var i = widget.index;
    var maxWidth = widget.constraints.maxWidth - avatarSize;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _currentHoverIndex = i;
        });
      },
      onExit: (_) {
        setState(() {
          _currentHoverIndex = -100;
        });
      },
      child: GestureDetector(
        onTap: () {
          print(widget.itemList[i].id);
          var isFirst =
              context.read<GlobalStateProvider>().isFirstEnterDetailPage;
          if (isFirst) {
            context
                .read<GlobalStateProvider>()
                .changeItNotFirstEnterDetailPage();
            context.push('/', extra: widget.itemList[i].id);
          } else {
            context.pop();
            context.push('/', extra: widget.itemList[i].id);
          }
        },
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.symmetric(vertical: 3.0),
          decoration: BoxDecoration(
            color: i == _currentHoverIndex
                ? Colors.grey.withOpacity(0.3)
                : Colors.transparent,
            border: BorderDirectional(end: BorderSide(color: Colors.black)),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: BorderDirectional(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.4))),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Tooltip(
                    message: widget.itemList[i].authorName == null
                        ? ''
                        : widget.itemList[i].authorName!,
                    verticalOffset: -30,
                    margin: EdgeInsets.only(left: 60),
                    child: widget.itemList[i].avatar!.contains('size')
                        ? Container(
                            height: avatarSize / 1.0,
                            width: avatarSize / 1.0,
                            decoration: BoxDecoration(
                              color: randomColor(),
                            ),
                            child: Center(
                              child: Text(
                                widget.itemList[i].authorName == null
                                    ? ''
                                    : widget.itemList[i].authorName!,
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 30,
                                    foreground: Paint()..color = Colors.white),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage(
                              height: avatarSize / 1.0,
                              width: avatarSize / 1.0,
                              imageUrl: widget.itemList[i].avatar!,
                              cacheKey: widget.itemList[i].avatar,
                              placeholder: (c, u) =>
                                  CircularProgressIndicator(),
                              errorWidget: (c, u, e) {
                                return Icon(Icons.account_circle);
                              },
                            ),
                          ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: maxWidth - 12,
                      child: Text(
                        '${widget.itemList[i].title}',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'medium',
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Container(
                      width: maxWidth - 12,
                      child: Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 120),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('[$_count条]'),
                                Flexible(
                                  child: Text(
                                    widget.itemList[i].lastPosterName == null
                                        ? ''
                                        : widget.itemList[i].lastPosterName!,
                                    style: TextStyle(
                                        fontFamily: 'light',
                                        overflow: TextOverflow.fade),
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Text(
                              ':这是测试数据，请你查收，样式展示22222222222222',
                              style: TextStyle(
                                  fontFamily: 'light',
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
        ),
      ),
    );
  }
}
