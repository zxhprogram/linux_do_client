import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:linux_do/config/GlobalConfig.dart';

var _dio = Dio()..options.baseUrl = 'https://linux.do';
var networkService = NetworkService();
const avatarPrefix = 'https://linux.do';

main() async {
  var l = await NetworkService().topicDetailById(254925);
  print(l);
}

class NetworkService {
  Future<List<PostDetail>> topicDetailById(int id) async {
    var r = await _dio.get('/t/$id.json');
    return (r.data['post_stream']['posts'] as List).map((e) {
      return PostDetail.fromJson(e);
    }).toList();
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
  int id;
  String name;
  String? username;
  String? create_at;
  String? cooked;

  PostDetail(this.id, this.name, this.username, this.create_at, this.cooked);

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(json['id'], json['name'], json['username'],
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
