

class Data {
  final String url;
  final String author;
  final String courseUuid;
  final String title;
  final String price;
  final String description;
  final int totalLectures;

  Data({required this.author,required this.courseUuid,required this.description,required this.price,required this.title,required this.totalLectures,required this.url,});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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

class Sector2 {
   final List<Data> data;
  final String sectorName;

  Sector2({
    required this.data,
    required this.sectorName,
  });

  factory Sector2.fromJson(Map<String, dynamic> json) {
    List<Data> data = (json['data'] as List)
        .map((courseJson) => Data.fromJson(courseJson))
        .toList();

    return Sector2(
      data: data,
      sectorName: json['sector_name'],
    );
  }
}
