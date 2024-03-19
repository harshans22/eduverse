class Comment {
  final User user;
  final String message;
  final String created;

  Comment({
    required this.user,
    required this.message,
    required this.created,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user: User.fromJson(json['user']),
      message: json['message'],
      created: json['created'],
    );
  }
}

class User {
  final String name;

  User({required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['username'],
    );
  }
}



class CourseSection {
  final String sectionTitle;
  final List episodes;
  final String totalDuration;

  CourseSection({
    required this.sectionTitle,
    required this.episodes,
    required this.totalDuration,
  });

  factory CourseSection.fromJson(Map<String, dynamic> json) {
    

    return CourseSection(
      sectionTitle: json['section_title'],
      episodes: json['episodes'],
      totalDuration: json['total_duration'],
    );
  }
}

class Coursedetails {
  final List<Comment> comments;
  final String author;
  final List<CourseSection> courseSections;
  final int totalLectures;
  final String totalDuration;
  final String title;
  final String description;
  final String created;
  final String updated;
  final String language;
  final String courseUuid;
  final String price;

  Coursedetails({
    required this.comments,
    required this.author,
    required this.courseSections,
    
    required this.totalLectures,
    required this.totalDuration,
    required this.title,
    required this.description,
    required this.created,
    required this.updated,
    required this.language,
    required this.courseUuid,
    required this.price,
  });

  factory Coursedetails.fromJson(Map<String, dynamic> json) {
    var commentList = json['comments'] as List;
    List<Comment> comments = commentList.map((comment) => Comment.fromJson(comment)).toList();

    var courseSectionList = json['course_section'] as List;
    List<CourseSection> courseSections =
        courseSectionList.map((section) => CourseSection.fromJson(section)).toList();

    return Coursedetails(
      comments: comments,
      author: json['author'],
      courseSections: courseSections,
     
      totalLectures: json['total_lectures'],
      totalDuration: json['total_duration'],
      title: json['title'],
      description: json['description'],
      created: json['created'],
      updated: json['updated'],
      language: json['language'],
      courseUuid: json['course_uuid'],
      price: json['price'],
    );
  }
}
