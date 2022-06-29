import 'package:assignment1_provider/models/failure/failure.dart';
import 'package:assignment1_provider/models/post/post.dart';
import 'package:either_dart/either.dart';

abstract class PostListRepository {
  Future<Either<List<Post>, Failure>> getPosts();
}
