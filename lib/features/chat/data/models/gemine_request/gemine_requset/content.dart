import 'part.dart';

class Content {
  List<Part>? parts;

  Content({this.parts});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    parts: (json['parts'] as List<dynamic>?)
        ?.map((e) => Part.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'parts': parts?.map((e) => e.toJson()).toList(),
  };
}
