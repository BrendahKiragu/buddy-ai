class CommentModel {
  final String id;
  final String topicId;
  final String userId;
  final String content;
  final bool isAnonymous;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentModel({
    required this.id,
    required this.topicId,
    required this.userId,
    required this.content,
    required this.isAnonymous,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'topicId': topicId,
    'userId': userId,
    'content': content,
    'isAnonymous': isAnonymous,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'] as String,
    topicId: json['topicId'] as String,
    userId: json['userId'] as String,
    content: json['content'] as String,
    isAnonymous: json['isAnonymous'] as bool,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  CommentModel copyWith({
    String? id,
    String? topicId,
    String? userId,
    String? content,
    bool? isAnonymous,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CommentModel(
    id: id ?? this.id,
    topicId: topicId ?? this.topicId,
    userId: userId ?? this.userId,
    content: content ?? this.content,
    isAnonymous: isAnonymous ?? this.isAnonymous,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
