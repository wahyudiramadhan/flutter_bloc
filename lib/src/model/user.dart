class User {
  String? title;
  String? content;
  String? image;
  String? created;

  User({this.title, this.content, this.image});

  User.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
    created = json['created']['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['created'] = created;
    return data;
  }
}
