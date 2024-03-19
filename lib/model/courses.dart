class FeaturedCourse {
  final String courseUuid;
  final String title;
  final String author;
  final String price;
  final String url;

  FeaturedCourse({
    required this.courseUuid,
    required this.title,
    required this.author,
    required this.price,
    required this.url,
  });

  factory FeaturedCourse.fromJson(Map<String, dynamic> json) {
    return FeaturedCourse(
      courseUuid: json['course_uuid'],
      title: json['title'],
      author: json['author'],
      price: json['price'],
      url: json['image_url'],
    );
  }
}

class Sector {
  final String sectorName;
  final String sectorUuid;
  final List<FeaturedCourse> featuredCourses;
  final String sectorImage;

  Sector({
    required this.sectorName,
    required this.sectorUuid,
    required this.featuredCourses,
    required this.sectorImage,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    List<FeaturedCourse> featuredCourses = (json['featured_course'] as List)
        .map((course) => FeaturedCourse.fromJson(course))
        .toList();

    return Sector(
      sectorName: json['sector_name'],
      sectorUuid: json['sector_uuid'],
      featuredCourses: featuredCourses,
      sectorImage: json['sector_image'],
    );
  }
}
