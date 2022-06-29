import 'package:assignment1_provider/models/failure/failure.dart';
import 'package:assignment1_provider/models/post/post.dart';
import 'package:assignment1_provider/models/post/post_detail.dart';
import 'package:either_dart/either.dart';

abstract class PostDetailRepository {
  Future<Either<PostDetail, Failure>> getPostDetail(int postId);
}
