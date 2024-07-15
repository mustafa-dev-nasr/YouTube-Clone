class ShortVideoModel {
  final String caption;
  final String shortVideo;
  final String userId;
  final DateTime datePublished;

  ShortVideoModel({
    required this.caption,
    required this.shortVideo,
    required this.userId,
    required this.datePublished,
  });

  // Convert a ShortVideoModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'shortVideo': shortVideo,
      'userId': userId,
      'datePublished': datePublished.toIso8601String(),
    };
  }

  // Create a ShortVideoModel instance from a map
  factory ShortVideoModel.fromMap(Map<String, dynamic> map) {
    return ShortVideoModel(
      caption: map['caption'],
      shortVideo: map['shortVideo'],
      userId: map['userId'],
      datePublished: DateTime.parse(map['datePublished']),
    );
  }
}