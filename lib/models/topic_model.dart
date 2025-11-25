class TopicModel {
  final String id;
  final String title;
  final int commentCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  TopicModel({
    required this.id,
    required this.title,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'commentCount': commentCount,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    id: json['id'] as String,
    title: json['title'] as String,
    commentCount: json['commentCount'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  TopicModel copyWith({
    String? id,
    String? title,
    int? commentCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TopicModel(
    id: id ?? this.id,
    title: title ?? this.title,
    commentCount: commentCount ?? this.commentCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
