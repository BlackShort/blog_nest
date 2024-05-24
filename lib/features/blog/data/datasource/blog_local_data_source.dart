import 'package:hive/hive.dart';
import 'package:nest/features/blog/data/models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({
    required List<BlogModel> blogs,
  });
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl({required this.box});

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get(i.toString()))
            .copyWith(posterName: box.get(i.toString())['poster_name']));
      }
    });
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) async {
    box.clear();
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        Map<String, dynamic> blog = blogs[i].toJson();
        blog['poster_name'] = blogs[i].posterName;
        box.put(i.toString(), blog);
      }
    });
  }
}
