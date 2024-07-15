class CommentModel {
  final String commentText;
  final String videoId;
  final String commentId;
  final String profilPic;
  final String displayName;

  CommentModel({
    required this.commentText,
    required this.videoId,
    required this.commentId,
    required this.profilPic,
    required this.displayName,
  });

  // Factory constructor to create an instance from a map
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentText: map['commentText'],
      videoId: map['videoId'],
      commentId: map['commentId'],
      profilPic: map['profilPic'],
      displayName: map['displayName'],
    );
  }

  // Method to convert the instance to a map
  Map<String, dynamic> toMap() {
    return {
      'commentText': commentText,
      'videoId': videoId,
      'commentId': commentId,
      'profilPic': profilPic,
      'displayName': displayName,
    };
  }
}
