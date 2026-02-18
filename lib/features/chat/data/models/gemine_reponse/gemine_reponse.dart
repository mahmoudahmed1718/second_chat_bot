import 'candidate.dart';
import 'usage_metadata.dart';

class GemineReponse {
  List<Candidate>? candidates;
  UsageMetadata? usageMetadata;
  String? modelVersion;
  String? responseId;

  GemineReponse({
    this.candidates,
    this.usageMetadata,
    this.modelVersion,
    this.responseId,
  });

  factory GemineReponse.fromJson(Map<String, dynamic> json) => GemineReponse(
    candidates: (json['candidates'] as List<dynamic>?)
        ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
        .toList(),
    usageMetadata: json['usageMetadata'] == null
        ? null
        : UsageMetadata.fromJson(json['usageMetadata'] as Map<String, dynamic>),
    modelVersion: json['modelVersion'] as String?,
    responseId: json['responseId'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'candidates': candidates?.map((e) => e.toJson()).toList(),
    'usageMetadata': usageMetadata?.toJson(),
    'modelVersion': modelVersion,
    'responseId': responseId,
  };
}
