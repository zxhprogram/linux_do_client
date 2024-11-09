import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../service/NetworkService.dart';

class ItemListPage extends StatefulWidget {
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<Item> _itemList = [];

  @override
  void initState() {
    super.initState();
    _loadResource();
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
          return ListView.builder(
              itemBuilder: (c, i) {
                return SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _itemList[i].pinned
                              ? Icon(AntDesign.pushpin_fill)
                              : Container(),
                          Container(
                            width: _itemList[i].pinned
                                ? constraints.maxWidth - 24
                                : constraints.maxWidth,
                            child: Text(
                              '${_itemList[i].title}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'normal',
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      CachedNetworkImage(
                        height: 30,
                        width: 30,
                        imageUrl: _itemList[i].avatar!,
                        placeholder: (c, u) => CircularProgressIndicator(),
                        errorWidget: (c, u, e) {
                          return Icon(Icons.account_circle);
                        },
                      ),
                    ],
                  ),
                );
              },
              itemCount: _itemList.length);
        },
      ),
    );
  }
}
