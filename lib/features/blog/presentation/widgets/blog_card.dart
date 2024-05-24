import 'package:flutter/material.dart';
import 'package:nest/core/theme/app_pallete.dart';
import 'package:nest/core/utils/calculate_reading_time.dart';
import 'package:nest/features/blog/domain/entities/blog.dart';
import 'package:nest/features/blog/presentation/pages/blog_viewer_page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        child: Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: blog.id,
              child: Image.network(
                blog.imageUrl,
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context, BlogViewerPage.route(blog));
        },
        child: Container(
          height: 200,
          margin: const EdgeInsets.all(16.0).copyWith(
            bottom: 4,
          ),
          width: double.maxFinite,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              color,
              AppPallete.transparentColor.withOpacity(0.2),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: blog.topics
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: Chip(
                                label: Text(e),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text('${calculateReadingTime(blog.content)} min'),
            ],
          ),
        ),
      ),
    ]);
  }
}
