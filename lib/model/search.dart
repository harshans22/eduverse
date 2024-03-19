

class search {
  final String courseUuid;
  final String title;
  
  final String author;
  final String price;
  final String description;
  final String url;
  final int totalLectures;

  search({
    required this.courseUuid,
    required this.title,

    required this.author,
    required this.price,
    required this.description,
    required this.totalLectures,
    required this.url,
  });

  factory search.fromJson(Map<String, dynamic> json) {
    return search(
      courseUuid: json['course_uuid'],
      title: json['title'],
      
      author: json['author'],
      price: json['price'],
      description: json['description'],
      totalLectures: json['total_lectures'],
      url: json['image_url'],
    );
  }
}
