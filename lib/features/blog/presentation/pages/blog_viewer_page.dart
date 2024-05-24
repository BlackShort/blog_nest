import 'package:flutter/material.dart';
import 'package:nest/core/theme/app_pallete.dart';
import 'package:nest/core/utils/calculate_reading_time.dart';
import 'package:nest/core/utils/format_date.dart';
import 'package:nest/features/blog/domain/entities/blog.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(blog: blog),
      );

  final Blog blog;
  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(blog.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                Text('By ${blog.posterName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${formatDateByddMMYYYY(blog.updatedAt)}.${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(child: Image.network(blog.imageUrl)),
                const SizedBox(
                  height: 20,
                ),
                Text(blog.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 2,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
