import 'package:assignment1_provider/models/failure/failure.dart';
import 'package:assignment1_provider/models/post/post_detail.dart';
import 'package:assignment1_provider/repository/post/post_detail_repository_implemantation.dart';
import 'package:assignment1_provider/utils/status.dart';
import 'package:assignment1_provider/view_model/post_list_vm.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

class PostDetailViewModel extends ChangeNotifier {
  late Either<PostDetail, Failure> _postDetail;
  late PostDetailRepositoryImplementation _postRepositoryImplementation;
  late PostListViewModel _postListViewModel;
  Status _status = Status.loading;
  void _setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  Status get status => _status;
  Either<PostDetail, Failure> get postDetail => _postDetail;
  void getPostDetail(int id) async {
    _setStatus(Status.loading);
    _postDetail = await _postRepositoryImplementation.getPostDetail(id);
    _setStatus(Status.completed);
  }

  void setRepositoryProvider(PostDetailRepositoryImplementation repo) {
    _postRepositoryImplementation = repo;
  }

  void setPostListViewModel(PostListViewModel model) {
    _postListViewModel = model;
    getPostDetail(_postListViewModel.selectedPostId);
  }
}
