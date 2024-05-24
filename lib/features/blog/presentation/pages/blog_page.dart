import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nest/core/common/widgets/loader.dart';
import 'package:nest/core/theme/app_pallete.dart';
import 'package:nest/core/utils/show_snackbar.dart';
import 'package:nest/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:nest/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:nest/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nest'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: const Icon(CupertinoIcons.add_circled),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        }, 
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 5 == 0
                      ? AppPallete.gradient1
                      : index % 5 == 1
                          ? AppPallete.gradient2
                          : index % 5 == 2
                              ? AppPallete.gradient3
                              : index % 5 == 3
                                  ? AppPallete.gradient4
                                  : AppPallete.gradient5,
                );
              },
            );
          }
          return const SizedBox();
        }));
  }
}
