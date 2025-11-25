class BlogModel {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String authorId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'imageUrl': imageUrl,
    'authorId': authorId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    id: json['id'] as String,
    title: json['title'] as String,
    content: json['content'] as String,
    imageUrl: json['imageUrl'] as String,
    authorId: json['authorId'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    String? authorId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BlogModel(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    imageUrl: imageUrl ?? this.imageUrl,
    authorId: authorId ?? this.authorId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
