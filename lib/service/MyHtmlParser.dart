import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

main() {
  String s =
      r'<p>从<a href=\"https://linux.do/t/topic/249783/4\">AIK 11.03 18:00后创建的账号已全部停用</a>继续讨论：</p>\n<p><div class=\"lightbox-wrapper\"><a class=\"lightbox\" href=\"https://linux.do/uploads/default/original/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06.jpeg\" data-download-href=\"https://linux.do/uploads/default/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06\" title=\"IMG_4667\"><img src=\"https://linux.do/uploads/default/optimized/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06_2_252x500.jpeg\" alt=\"IMG_4667\" data-base62-sha1=\"vjZl7Tg2np7Xi8pQXdmppsuxT8y\" width=\"252\" height=\"500\" srcset=\"https://linux.do/uploads/default/optimized/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06_2_252x500.jpeg, https://linux.do/uploads/default/optimized/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06_2_378x750.jpeg 1.5x, https://linux.do/uploads/default/optimized/3X/d/b/db85d9e3fc4563f38252a8bbe1d58cb2f0ecce06_2_504x1000.jpeg 2x\" data-dominant-color=\"52424E\"><div class=\"meta\"><svg class=\"fa d-icon d-icon-far-image svg-icon\" aria-hidden=\"true\"><use href=\"#far-image\"></use></svg><span class=\"filename\">IMG_4667</span><span class=\"informations\">1320×2613 544 KB</span><svg class=\"fa d-icon d-icon-discourse-expand svg-icon\" aria-hidden=\"true\"><use href=\"#discourse-expand\"></use></svg></div></a></div><br>\n<div class=\"lightbox-wrapper\"><a class=\"lightbox\" href=\"https://linux.do/uploads/default/original/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3.jpeg\" data-download-href=\"https://linux.do/uploads/default/3ef013d709ee3ce8423107ea5035326df487fbb3\" title=\"IMG_4668\"><img src=\"https://linux.do/uploads/default/optimized/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3_2_252x500.jpeg\" alt=\"IMG_4668\" data-base62-sha1=\"8YLXWwSPhXUiQurIv1WSLaUvx4L\" width=\"252\" height=\"500\" srcset=\"https://linux.do/uploads/default/optimized/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3_2_252x500.jpeg, https://linux.do/uploads/default/optimized/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3_2_378x750.jpeg 1.5x, https://linux.do/uploads/default/optimized/3X/3/e/3ef013d709ee3ce8423107ea5035326df487fbb3_2_504x1000.jpeg 2x\" data-dominant-color=\"4B315C\"><div class=\"meta\"><svg class=\"fa d-icon d-icon-far-image svg-icon\" aria-hidden=\"true\"><use href=\"#far-image\"></use></svg><span class=\"filename\">IMG_4668</span><span class=\"informations\">1320×2613 635 KB</span><svg class=\"fa d-icon d-icon-discourse-expand svg-icon\" aria-hidden=\"true\"><use href=\"#discourse-expand\"></use></svg></div></a></div><br>\n<div class=\"lightbox-wrapper\"><a class=\"lightbox\" href=\"https://linux.do/uploads/default/original/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82.jpeg\" data-download-href=\"https://linux.do/uploads/default/3d0430a51085a9cf307e62bb2a89a21d2eca4c82\" title=\"IMG_4669\"><img src=\"https://linux.do/uploads/default/optimized/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82_2_252x500.jpeg\" alt=\"IMG_4669\" data-base62-sha1=\"8HM6n3dalsIeGLKpABUohOUOZ2y\" width=\"252\" height=\"500\" srcset=\"https://linux.do/uploads/default/optimized/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82_2_252x500.jpeg, https://linux.do/uploads/default/optimized/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82_2_378x750.jpeg 1.5x, https://linux.do/uploads/default/optimized/3X/3/d/3d0430a51085a9cf307e62bb2a89a21d2eca4c82_2_504x1000.jpeg 2x\" data-dominant-color=\"4C3871\"><div class=\"meta\"><svg class=\"fa d-icon d-icon-far-image svg-icon\" aria-hidden=\"true\"><use href=\"#far-image\"></use></svg><span class=\"filename\">IMG_4669</span><span class=\"informations\">1320×2613 690 KB</span><svg class=\"fa d-icon d-icon-discourse-expand svg-icon\" aria-hidden=\"true\"><use href=\"#discourse-expand\"></use></svg></div></a></div><br>\n<div class=\"lightbox-wrapper\"><a class=\"lightbox\" href=\"https://linux.do/uploads/default/original/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348.jpeg\" data-download-href=\"https://linux.do/uploads/default/e5633dff0f5c0dcd92f0a725786888ec4e232348\" title=\"IMG_4670\"><img src=\"https://linux.do/uploads/default/optimized/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348_2_569x500.jpeg\" alt=\"IMG_4670\" data-base62-sha1=\"wJfXTIDqDjD1QBD9WNi8E8waCgw\" width=\"569\" height=\"500\" srcset=\"https://linux.do/uploads/default/optimized/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348_2_569x500.jpeg, https://linux.do/uploads/default/optimized/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348_2_853x750.jpeg 1.5x, https://linux.do/uploads/default/optimized/3X/e/5/e5633dff0f5c0dcd92f0a725786888ec4e232348_2_1138x1000.jpeg 2x\" data-dominant-color=\"41325D\"><div class=\"meta\"><svg class=\"fa d-icon d-icon-far-image svg-icon\" aria-hidden=\"true\"><use href=\"#far-image\"></use></svg><span class=\"filename\">IMG_4670</span><span class=\"informations\">1320×1158 292 KB</span><svg class=\"fa d-icon d-icon-discourse-expand svg-icon\" aria-hidden=\"true\"><use href=\"#discourse-expand\"></use></svg></div></a></div><br>\n（敏感信息已打码，对话完整截图，无断章取义和曲解部分）</p>\n<p>已经搬运成“外交”事故了 <img src=\"https://linux.do/uploads/default/original/3X/2/e/2e09f3a3c7b27eacbabe9e9614b06b88d5b06343.png?v=12\" title=\":tieba_087:\" class=\"emoji emoji-custom\" alt=\":tieba_087:\" loading=\"lazy\" width=\"20\" height=\"20\"></p>\n<p>一开始为什么没问题？因为发在L站的帖子标明了出处，符合FAQ中的搬运要求。</p>\n<p>后面有L站用户发帖挂搬运者，因为用词涉及辱骂且FAQ中已写明不支持挂人，所以挂人帖已删除。</p>\n<p>再然后应该是有人私聊搬运的佬友，他也配合了对方的诉求清空、删除了搬运帖。</p>\n<p>本以为事情结束了，哪知道对方管理找过来索要佬友的IP信息，应该是要追责其在对方论坛的账号。事情成了“外交”事故。</p>\n<p>对于此次事故：</p>\n<ol>\n<li>由于发帖人标明原帖，未违反L站搬运规则，且事后也主动删除了搬运帖。所以搬运的佬友不会在L站受到额外处理。</li>\n<li>已关注贵站的相关网址、关键词，确保涉及贵站内容经过管理审核后方可发出，以避免后续出现此类“外交”事故。</li>\n<li>警钟常鸣，搬运要留心啊。</li>\n</ol>\n<p>最后，请仔细阅读论坛FAQ <a href=\"https://linux.do/faq\" class=\"inline-onebox\">常见问题解答 - LINUX DO</a></p>';

  List<HtmlElement> elements = parseHtml(s);
  print(elements);
  // List<HtmlContent> c = parseHtml1(s);
  // print(c);
  print(1);
}

List<HtmlContent> parseHtml1(String htmlContent) {
  var document = html_parser.parse(htmlContent);
  return parseHtmlToContentList(document.body!);
}

List<HtmlContent> parseHtmlToContentList(dom.Element element) {
  List<HtmlContent> contents = [];

  for (var node in element.nodes) {
    if (node is dom.Text) {
      // 处理普通文本节点
      String text = node.text.trim();
      if (text.isNotEmpty) {
        contents.add(TextContent(text));
      }
    } else if (node is dom.Element) {
      // 处理带标签的节点
      String tag = node.localName ?? '';
      String innerText = node.text.trim();
      Map<String, String> attributes =
          Map<String, String>.from(node.attributes);

      if (innerText.isNotEmpty) {
        contents
            .add(TagContent(tag: tag, text: innerText, attributes: attributes));
      }
    }
  }

  return contents;
}

abstract class HtmlContent {}

class TextContent extends HtmlContent {
  final String text;

  TextContent(this.text);

  @override
  String toString() {
    return 'TextContent(text: "$text")';
  }
}

class TagContent extends HtmlContent {
  final String tag;
  final String text;
  final Map<String, String> attributes;

  TagContent({
    required this.tag,
    required this.text,
    required this.attributes,
  });

  @override
  String toString() {
    return 'TagContent(tag: "$tag", text: "$text", attributes: $attributes)';
  }
}

List<HtmlElement> parseHtml(String htmlContent) {
  var document = html_parser.parse(htmlContent);
  return document.body!.children.map((e) => parseHtmlToElement(e)).toList();
}

HtmlElement parseHtmlToElement(dom.Element element) {
  // 提取标签、文本和属性
  String tag = element.localName ?? '';
  String? text = element.text.isNotEmpty ? element.text : null;
  Map<String, String>? attributes = element.attributes.isNotEmpty
      ? Map<String, String>.from(element.attributes)
      : null;

  // 递归处理子元素
  List<HtmlElement> children =
      element.children.map((child) => parseHtmlToElement(child)).toList();

  // 返回解析后的 HtmlElement 对象
  return HtmlElement(
    tag: tag,
    text: text,
    attributes: attributes,
    children: children,
  );
}

class HtmlElement {
  String tag; // HTML 标签名，例如 'p'，'a'
  String? text; // 标签中的文本内容
  Map<String, String>? attributes; // 标签的属性
  List<HtmlElement> children; // 嵌套的子元素

  HtmlElement({
    required this.tag,
    this.text,
    this.attributes,
    this.children = const [],
  });

  bool isEmpty() {
    return false;
  }

  void p() {
    if (tag == 'p') {

    }
  }

  @override
  String toString() {
    return 'HtmlElement(tag: $tag, text: $text, attributes: $attributes, children: $children)';
  }
}

class Content {
  String? text;
}

enum tag { a, p, img }

void parse(String s) {
  s = s.replaceAll('\n', '');
  s = s.replaceAll('<br>', '');
  var document = html_parser.parse(s);
  print('-----------------------------------------');
  if (document.body == null) {
    return;
  }
  for (var e in document.body!.children) {
    if (e.children.isEmpty) {
// print('${e.outerHtml}');
    } else {
      for (var ee in e.children) {
        if (ee.children.length == 1) {
          print(ee.outerHtml);
          continue;
        }
        parse(ee.outerHtml);
      }
    }
  }
}

abstract class MyElement {}

class P extends MyElement {
  List<MyElement> content;

  P(this.content);
}

class A extends MyElement {
  String link;
  String? content;

  A(this.link);
}

class Img extends MyElement {
  String imgUrl;
  String? alt;
  int? width;
  int? height;

  Img({required this.imgUrl, this.alt, this.width, this.height});
}
