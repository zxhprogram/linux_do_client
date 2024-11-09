import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linux_do/service/NetworkService.dart';

class TopicDetailPage extends StatefulWidget {
  final int? topicId;

  TopicDetailPage({this.topicId = -1});

  @override
  State<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  PostDetail? detail = null;

  @override
  void initState() {
    super.initState();
    _loadResource();
  }

  Future<void> _loadResource() async {
    print('load detail ${widget.topicId}');
    if (widget.topicId == -1 || widget.topicId == null) {
      return;
    }
    var de = await networkService.topicDetailById(widget.topicId!);
    setState(() {
      detail = de;
      print('detail -> ${detail?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: widget.topicId == null || widget.topicId == -1
          ? Center(
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: SvgPicture.asset(
                    height: 200,
                    width: 200,
                    'assets/svg/liugou.svg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  // color: Colors.pinkAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail?.title == null ? '' : detail!.title,
                        style: TextStyle(fontSize: 24, fontFamily: 'bold'),
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
