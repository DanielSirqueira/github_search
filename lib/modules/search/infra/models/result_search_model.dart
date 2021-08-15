import 'dart:convert';

import 'package:github_search/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String title;
  final String content;
  final String img;

  ResultSearchModel(
      {required this.title, required this.content, required this.img})
      : super(title: title, content: content, img: img);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'img': img,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      title: map['login'],
      content: map['url'],
      img: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
