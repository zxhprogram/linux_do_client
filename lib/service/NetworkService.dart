import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:linux_do/config/GlobalConfig.dart';
import 'package:html/parser.dart' as html_parser;

var _dio = Dio()..options.baseUrl = 'https://linux.do';
var networkService = NetworkService();
const avatarPrefix = 'https://linux.do';
var _cacheMap = <dynamic, Cache>{};

main() async {
  String s =
      r'<p>从<a href=\"https://linux.do/t/topic/249783/4\">AIK 11.03 18:00后创建的账号已全部停用</a>继续讨论：</p>\n<p><div class=\"lightbox-wrapper\"><a class=\"lightbox\" href=\"https://linux.do/uploads/default/original/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06.jpeg\" data-download-href=\"https://linux.do/uploads/default/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06\" title=\"IMG_4667\"><img src=\"https://linux.do/uploads/default/optimized/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06_2_252x500.jpeg\" alt=\"IMG_4667\" data-base62-sha1=\"vjZl7Tg2np7Xi8pQXdmppsuxT8y\" width=\"252\" height=\"500\" srcset=\"https://linux.do/uploads/default/optimized/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06_2_252x500.jpeg, https://linux.do/uploads/default/optimized/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06_2_378x750.jpeg 1.5x, https://linux.do/uploads/default/optimized/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06_2_504x1000.jpeg 2x\" data-dominant-color=\"52424E\"><div class=\"meta\"><svg class=\"fa d-icon d-icon-far-image svg-icon\" aria-hidden=\"true\"><use href=\"#far-image\"></use></svg><span class=\"filename\">IMG_4667</span><span class=\"informations\">1320×2613 544 KB</span><svg class=\"fa d-icon d-icon-discourse-expand svg-icon\" aria-hidden=\"true\"><use href=\"#discourse-expand\"></use></svg></div></a></div><br>\n<div class=\"lightbox-wrapper\"><a class=\"lightbox\" href=\"https://linux.do/uploads/default/original/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3.jpeg\" data-download-href=\"https://linux.do/uploads/default/3ef013d709ee3ce8423107ea5035326df487fbb3\" title=\"IMG_4668\"><img src=\"https://linux.do/uploads/default/optimized/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3_2_252x500.jpeg\" alt=\"IMG_4668\" data-base62-sha1=\"8YLXWwSPhXUiQurIv1WSLaUvx4L\" width=\"252\" height=\"500\" srcset=\"https://linux.do/uploads/default/optimized/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3_2_252x500.jpeg, https://linux.do/uploads/default/optimized/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3_2_378x750.jpeg 1.5x, https://linux.do/uploads/default/optimized/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3_2_504x1000.jpeg 2x\" data-dominant-color=\"4B315C\"><div class=\"meta\"><svg class=\"fa d-icon d-icon-far-image svg-icon\" aria-hidden=\"true\"><use href=\"#far-image\"></use></svg><span class=\"filename\">IMG_4668</span><span class=\"informations\">1320×2613 635 KB</span><svg class=\"fa d-icon d-icon-discourse-expand svg-icon\" aria-hidden=\"true\"><use href=\"#discourse-expand\"></use></svg></div></a></div><br>\n<div class=\"lightbox-wrapper\"><a class=\"lightbox\" href=\"https://linux.do/uploads/default/original/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82.jpeg\" data-download-href=\"https://linux.do/uploads/default/3d0430a51085a9cf307e62bb2a89a21d2eca4c82\" title=\"IMG_4669\"><img src=\"https://linux.do/uploads/default/optimized/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82_2_252x500.jpeg\" alt=\"IMG_4669\" data-base62-sha1=\"8HM6n3dalsIeGLKpABUohOUOZ2y\" width=\"252\" height=\"500\" srcset=\"https://linux.do/uploads/default/optimized/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82_2_252x500.jpeg, https://linux.do/uploads/default/optimized/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82_2_378x750.jpeg 1.5x, https://linux.do/uploads/default/optimized/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82_2_504x1000.jpeg 2x\" data-dominant-color=\"4C3871\"><div class=\"meta\"><svg class=\"fa d-icon d-icon-far-image svg-icon\" aria-hidden=\"true\"><use href=\"#far-image\"></use></svg><span class=\"filename\">IMG_4669</span><span class=\"informations\">1320×2613 690 KB</span><svg class=\"fa d-icon d-icon-discourse-expand svg-icon\" aria-hidden=\"true\"><use href=\"#discourse-expand\"></use></svg></div></a></div><br>\n<div class=\"lightbox-wrapper\"><a class=\"lightbox\" href=\"https://linux.do/uploads/default/original/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348.jpeg\" data-download-href=\"https://linux.do/uploads/default/e5633dff0f5c0dcd92f0a725786888ec4e232348\" title=\"IMG_4670\"><img src=\"https://linux.do/uploads/default/optimized/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348_2_569x500.jpeg\" alt=\"IMG_4670\" data-base62-sha1=\"wJfXTIDqDjD1QBD9WNi8E8waCgw\" width=\"569\" height=\"500\" srcset=\"https://linux.do/uploads/default/optimized/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348_2_569x500.jpeg, https://linux.do/uploads/default/optimized/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348_2_853x750.jpeg 1.5x, https://linux.do/uploads/default/optimized/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348_2_1138x1000.jpeg 2x\" data-dominant-color=\"41325D\"><div class=\"meta\"><svg class=\"fa d-icon d-icon-far-image svg-icon\" aria-hidden=\"true\"><use href=\"#far-image\"></use></svg><span class=\"filename\">IMG_4670</span><span class=\"informations\">1320×1158 292 KB</span><svg class=\"fa d-icon d-icon-discourse-expand svg-icon\" aria-hidden=\"true\"><use href=\"#discourse-expand\"></use></svg></div></a></div><br>\n（敏感信息已打码，对话完整截图，无断章取义和曲解部分）</p>\n<p>已经搬运成“外交”事故了 <img src=\"https://linux.do/uploads/default/original/3X/2/e/2e09f3a3c7b27eacbabe9e9614b06b88d5b06343.png?v=12\" title=\":tieba_087:\" class=\"emoji emoji-custom\" alt=\":tieba_087:\" loading=\"lazy\" width=\"20\" height=\"20\"></p>\n<p>一开始为什么没问题？因为发在L站的帖子标明了出处，符合FAQ中的搬运要求。</p>\n<p>后面有L站用户发帖挂搬运者，因为用词涉及辱骂且FAQ中已写明不支持挂人，所以挂人帖已删除。</p>\n<p>再然后应该是有人私聊搬运的佬友，他也配合了对方的诉求清空、删除了搬运帖。</p>\n<p>本以为事情结束了，哪知道对方管理找过来索要佬友的IP信息，应该是要追责其在对方论坛的账号。事情成了“外交”事故。</p>\n<p>对于此次事故：</p>\n<ol>\n<li>由于发帖人标明原帖，未违反L站搬运规则，且事后也主动删除了搬运帖。所以搬运的佬友不会在L站受到额外处理。</li>\n<li>已关注贵站的相关网址、关键词，确保涉及贵站内容经过管理审核后方可发出，以避免后续出现此类“外交”事故。</li>\n<li>警钟常鸣，搬运要留心啊。</li>\n</ol>\n<p>最后，请仔细阅读论坛FAQ <a href=\"https://linux.do/faq\" class=\"inline-onebox\">常见问题解答 - LINUX DO</a></p>';

  // extractTextFromHtml(s);
  // var r = extractTextFromHtml(s);
  // print(r);
}

void extractTextFromHtml(String htmlContent) {
  var document = html_parser.parse(htmlContent);

  var chd = document.children;
  var echd = chd[0].children;
  var span = TextSpan();
  for (var ee in echd) {
    if (ee.children.isEmpty) {
      if (span.children == null) {}
      span.children?.add(TextSpan());
      continue;
    }
    extractTextFromHtml(ee.outerHtml);
    // var eechd = ee.children;
    // for (var eee in eechd) {
    //   print(eee.innerHtml);
    // }
  }
}


class Cache<K, V> {
  final K k;
  final DateTime timestamp;
  final V v;

  Cache(this.k, this.timestamp, this.v);
}

class NetworkService {
  Future<int> topicCommentCount(int id) async {
    if (_cacheMap[id] != null &&
        _cacheMap[id]!
            .timestamp
            .isAfter(DateTime.timestamp().subtract(Duration(minutes: 5)))) {
      print('hit cache : $id -> ${_cacheMap[id]!.v}');
      return _cacheMap[id]!.v;
    }
    _cacheMap.remove(id);
    var r = await _dio.get('/t/$id.json');
    var data = r.data['post_stream']['stream'];
    var result = data == null ? 0 : (data as List).length;
    _cacheMap[id] = Cache(id, DateTime.timestamp(), result);
    return result;
  }

  Future<PostDetail> topicDetailById(int id) async {
    var r = await _dio.get('/t/$id.json');
    var posts = (r.data['post_stream']['posts'] as List).map((e) {
      return PostDetailOfPost.fromJson(e);
    }).toList();
    return PostDetail(posts, r.data['title']);
  }

  Future<List<Item>> latest({int pageIndex = 0}) async {
    String url = '/latest.json';
    if (pageIndex != 0) {
      url = '?no_definitions=true&page=$pageIndex';
    }
    var r = await _dio.get(url);
    var latest = Latest.frmJson(r.data);
    var users = latest.users;
    return latest.topic_list.topics.map((e) {
      return Item()
        ..id = e.id
        ..title = e.title
        ..pinned = e.pinned
        ..authorName = _findUserName(
            users,
            e.posters
                .where((p) {
                  return p.description.contains('原始发帖人');
                })
                .firstOrNull
                ?.user_id)
        ..lastPosterName = _findUserName(
            users,
            e.posters
                .where((p) {
                  return p.extras == 'latest';
                })
                .firstOrNull
                ?.user_id)
        ..avatar = users
            .where((x) {
              return x.id == e.posters[0].user_id;
            })
            .firstOrNull
            ?.avatar();
    }).toList();
  }

  String? _findUserName(List<User> users, int? userId) {
    return users
        .where((u) {
          return u.id == userId;
        })
        .firstOrNull
        ?.name;
  }
}

class PostDetail {
  List<PostDetailOfPost> posts;
  String title;

  PostDetail(this.posts, this.title);

  @override
  String toString() {
    return '$title';
  }
}

class PostDetailOfPost {
  int id;
  String? name;
  String? username;
  String? create_at;
  String? title;
  String? cooked;

  PostDetailOfPost(
      this.id, this.name, this.username, this.create_at, this.cooked,
      {this.title});

  factory PostDetailOfPost.fromJson(Map<String, dynamic> json) {
    print('postdetailofpost -> $json');
    return PostDetailOfPost(json['id'], json['name'], json['username'],
        json['create_at'], json['cooked']);
  }
}

class Item {
  int? id;
  String? title;
  String? avatar;
  bool pinned;
  String? authorName;
  String? lastPosterName;

  Item(
      {this.authorName,
      this.lastPosterName,
      this.id,
      this.title,
      this.avatar,
      this.pinned = false});
}

class Latest {
  List<User> users;
  List<PrimaryGroup> primary_groups;
  List<FlairGroup> flair_groups;
  Topic topic_list;

  Latest(
      {required this.users,
      required this.primary_groups,
      required this.flair_groups,
      required this.topic_list});

  factory Latest.frmJson(Map<String, dynamic> json) {
    return Latest(
        users: (json['users'] as List).map((e) {
          return User.fromJson(e);
        }).toList(),
        primary_groups: (json['primary_groups'] as List).map((e) {
          return PrimaryGroup.fromJson(e);
        }).toList(),
        flair_groups: (json['flair_groups'] as List).map((e) {
          return FlairGroup.fromJson(e);
        }).toList(),
        topic_list: Topic.fromJson(json['topic_list']));
  }
}

class Topic {
  bool can_create_topic;
  String more_topics_url;
  int per_page;
  List<String> top_tags;
  List<TopicItem> topics;

  Topic(
      {required this.can_create_topic,
      required this.more_topics_url,
      required this.per_page,
      required this.top_tags,
      required this.topics});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
        can_create_topic: json['can_create_topic'],
        more_topics_url: json['more_topics_url'],
        per_page: json['per_page'],
        top_tags: (json['top_tags'] as List).map((e) {
          return e.toString();
        }).toList(),
        topics: (json['topics'] as List).map((e) {
          return TopicItem.fromJson(e);
        }).toList());
  }
}

class TopicItem {
  int id;
  String title;
  String fancy_title;
  String slug;
  int posts_count;
  int reply_count;
  int highest_post_number;
  String? image_url;
  String? create_at;
  String last_posted_at;
  bool bumped;
  String bumped_at;
  String archetype;
  bool unseen;
  bool pinned;
  bool? unpinned;
  bool visible;
  bool closed;
  bool archived;
  bool? bookmarked;
  bool? linked;
  List<String> tags;

  // List<String> tags_descriptions;
  int views;
  int like_count;
  bool has_summary;
  String? last_poster_username;
  int category_id;
  bool pinned_globally;
  bool? featured_link;
  bool has_accepted_answer;
  bool can_have_answer;
  bool? can_vot;
  List<Poster> posters;

  TopicItem(
      {required this.id,
      required this.title,
      required this.fancy_title,
      required this.slug,
      required this.posts_count,
      required this.reply_count,
      required this.highest_post_number,
      this.image_url,
      this.create_at,
      required this.last_posted_at,
      required this.bumped,
      required this.bumped_at,
      required this.archetype,
      required this.unseen,
      required this.pinned,
      this.unpinned,
      required this.visible,
      required this.closed,
      required this.archived,
      this.bookmarked,
      this.linked,
      required this.tags,
      // required this.tags_descriptions,
      required this.views,
      required this.like_count,
      required this.has_summary,
      this.last_poster_username,
      required this.category_id,
      required this.pinned_globally,
      this.featured_link,
      required this.has_accepted_answer,
      required this.can_have_answer,
      this.can_vot,
      required this.posters});

  factory TopicItem.fromJson(Map<String, dynamic> json) {
    return TopicItem(
        id: json['id'],
        title: json['title'],
        fancy_title: json['fancy_title'],
        slug: json['slug'],
        posts_count: json['posts_count'],
        reply_count: json['reply_count'],
        highest_post_number: json['highest_post_number'],
        create_at: json['create_at'],
        last_posted_at: json['last_posted_at'],
        bumped: json['bumped'],
        bumped_at: json['bumped_at'],
        archetype: json['archetype'],
        unseen: json['unseen'],
        pinned: json['pinned'],
        visible: json['visible'],
        closed: json['closed'],
        archived: json['archived'],
        tags: (json['tags'] as List).map((e) {
          return e.toString();
        }).toList(),
        // tags_descriptions: (json['tags_descriptions'] as List).map((e) {
        //   return e.toString();
        // }).toList(),
        views: json['views'],
        like_count: json['like_count'],
        has_summary: json['has_summary'],
        last_poster_username: json['last_poster_username'],
        category_id: json['category_id'],
        pinned_globally: json['pinned_globally'],
        has_accepted_answer: json['has_accepted_answer'],
        can_have_answer: json['can_have_answer'],
        can_vot: json['can_vot'],
        posters: (json['posters'] as List).map((e) {
          return Poster.fromJson(e);
        }).toList());
  }
}

class Poster {
  String? extras;
  String description;
  int user_id;
  int? primary_group_id;
  int? flair_group_id;

  Poster(
      {this.extras,
      required this.description,
      required this.user_id,
      this.primary_group_id,
      this.flair_group_id});

  factory Poster.fromJson(Map<String, dynamic> json) {
    return Poster(
        extras: json['extras'],
        description: json['description'],
        user_id: json['user_id'],
        flair_group_id: json['flair_group_id']);
  }
}

class FlairGroup {
  int id;
  String name;
  String flair_url;
  String flair_bg_color;
  String flair_color;

  FlairGroup(
      {required this.id,
      required this.name,
      required this.flair_url,
      required this.flair_bg_color,
      required this.flair_color});

  factory FlairGroup.fromJson(Map<String, dynamic> json) {
    return FlairGroup(
        id: json['id'],
        name: json['name'],
        flair_url: json['flair_url'],
        flair_bg_color: json['flair_bg_color'],
        flair_color: json['flair_color']);
  }
}

class PrimaryGroup {
  int id;
  String name;

  PrimaryGroup({required this.id, required this.name});

  factory PrimaryGroup.fromJson(Map<String, dynamic> json) {
    return PrimaryGroup(id: json['id'], name: json['name']);
  }
}

class User {
  int id;
  String username;
  String? name;
  String avatar_template;
  String? flair_name;
  String? flair_url;
  String? flair_bg_color;
  String? flair_color;
  int? flair_group_id;
  int trust_level;

  User(
      {required this.id,
      required this.username,
      this.name,
      required this.avatar_template,
      this.flair_name,
      this.flair_url,
      this.flair_bg_color,
      this.flair_color,
      this.flair_group_id,
      required this.trust_level});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        name: json['name'],
        avatar_template: json['avatar_template'],
        flair_name: json['flair_name'],
        flair_url: json['flair_url'],
        flair_bg_color: json['flair_bg_color'],
        flair_color: json['flair_color'],
        flair_group_id: json['flair_group_id'],
        trust_level: json['trust_level']);
  }

  String avatar() {
    var r = avatar_template.split('/').map((e) {
      if (e == '{size}') {
        return '/$avatarSize';
      }
      return '/$e';
    }).toList();
    StringBuffer sb = StringBuffer();
    for (var s in r) {
      sb.write(s);
    }
    var result = '$avatarPrefix${sb.toString()}';
    if (kDebugMode) {
      print('$avatar_template -> $result');
    }
    return result;
  }
}
