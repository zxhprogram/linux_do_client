import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linux_do/service/NetworkService.dart';

class TopicDetailPage extends StatefulWidget {
  final int? topicId;

  TopicDetailPage({this.topicId = -1});

  @override
  State<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  @override
  void initState() {
    super.initState();
    _loadResource();
  }

  Future<void> _loadResource() async {
    if (widget.topicId == -1) {
      return;
    }
    await networkService.topicDetailById(widget.topicId!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: widget.topicId == null || widget.topicId == -1
          ? Column(
              children: [
                Container(
                  height: 80,
                  color: Colors.blue,
                  child: Text(
                    '空空如也',
                    style: TextStyle(
                        fontFamily: 'normal',
                        foreground: Paint()..color = Colors.white,
                        fontSize: 30),
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  // color: Colors.pinkAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '今天白天我在课堂上睡着了',
                        style: TextStyle(fontSize: 30, fontFamily: 'bold'),
                      ),
                      Row(
                        children: [
                          Container(
                            color: Colors.grey.withOpacity(0.6),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    CommunityMaterialIcons.water,
                                    color: Colors.greenAccent,
                                  ),
                                  Text(
                                    '搞三捻七',
                                    style: TextStyle(fontFamily: 'light'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.red.withOpacity(0.6),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    CommunityMaterialIcons.water,
                                    color: Colors.blueAccent,
                                  ),
                                  Text(
                                    '搞三捻七',
                                    style: TextStyle(fontFamily: 'light'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.yellowAccent.withOpacity(0.6),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    CommunityMaterialIcons.pipe_leak,
                                    color: Colors.blueAccent,
                                  ),
                                  Text(
                                    '搞三捻七',
                                    style: TextStyle(fontFamily: 'light'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}