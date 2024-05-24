import 'package:fpdart/fpdart.dart';
import 'package:nest/core/error/failure.dart';
import 'package:nest/core/usecase/usecase.dart';
import 'package:nest/features/blog/domain/entities/blog.dart';
import 'package:nest/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
