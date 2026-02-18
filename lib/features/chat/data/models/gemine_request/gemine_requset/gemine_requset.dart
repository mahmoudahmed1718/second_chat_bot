import 'content.dart';

class GemineRequset {
  List<Content>? contents;

  GemineRequset({this.contents});

  factory GemineRequset.fromJson(Map<String, dynamic> json) => GemineRequset(
    contents: (json['contents'] as List<dynamic>?)
        ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'contents': contents?.map((e) => e.toJson()).toList(),
  };
}
