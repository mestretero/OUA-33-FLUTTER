class Media {
  final String type;
  final String url;

  Media({
    required this.type,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'type': type,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      url: map['url'],
      type: map['type'],
    );
  }
}
