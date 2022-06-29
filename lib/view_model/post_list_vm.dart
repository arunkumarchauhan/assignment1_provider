import 'package:assignment1_provider/models/failure/failure.dart';
import 'package:assignment1_provider/models/post/post.dart';
import 'package:assignment1_provider/repository/post/post_list_repository_implementation.dart';
import 'package:assignment1_provider/utils/status.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

class PostListViewModel extends ChangeNotifier {
  late PostListRepositoryImplementation _postRepositoryImplementation;
  late Either<List<Post>, Failure> _posts;
  Status _status = Status.loading;
  int _selectedPostId = 0;
  void _setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  void setRepositoryProvider(PostListRepositoryImplementation repo) {
    _postRepositoryImplementation = repo;
  }

  void getPostLists() async {
    _setStatus(Status.loading);
    _posts = await _postRepositoryImplementation.getPosts();
    _setStatus(Status.completed);
  }

  void setSelectedPostId(int id) {
    _selectedPostId = id;
    notifyListeners();
  }

  int get selectedPostId => _selectedPostId;

  Status get status => _status;

  Either<List<Post>, Failure> get posts => _posts;
}
