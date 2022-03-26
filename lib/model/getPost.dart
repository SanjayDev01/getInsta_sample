class GetPosts {
  GetPosts({
    required this.status,
    required this.message,
    required this.posts,
  });
  late final int status;
  late final String message;
  late final List<Posts> posts;

  GetPosts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    posts = List.from(json['posts']).map((e) => Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['posts'] = posts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Posts {
  Posts({
    required this.images,
    required this.description,
    required this.interactions,
    required this.postedBy,
    required this.profileImage,
  });
  late final List<String> images;
  late final String description;
  late final Interactions interactions;
  late final String postedBy;
  late final String profileImage;

  Posts.fromJson(Map<String, dynamic> json) {
    images = List.castFrom<dynamic, String>(json['images']);
    description = json['description'];
    interactions = Interactions.fromJson(json['interactions']);
    postedBy = json['postedBy'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['images'] = images;
    _data['description'] = description;
    _data['interactions'] = interactions.toJson();
    _data['postedBy'] = postedBy;
    _data['profileImage'] = profileImage;
    return _data;
  }
}

class Interactions {
  Interactions({
    required this.likes,
    required this.comments,
    required this.bookmarked,
  });
  late final int likes;
  late final int comments;
  late final bool bookmarked;

  Interactions.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    comments = json['comments'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['likes'] = likes;
    _data['comments'] = comments;
    _data['bookmarked'] = bookmarked;
    return _data;
  }
}
