import 'package:assignment1_provider/models/failure/failure.dart';
import 'package:assignment1_provider/models/post/post_detail.dart';
import 'package:assignment1_provider/utils/status.dart';
import 'package:assignment1_provider/view_model/post_detail_vm.dart';
import 'package:assignment1_provider/view_model/post_list_vm.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post List Screen",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Consumer<PostDetailViewModel>(
        builder: (BuildContext context, model, _) {
          if (model.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (model.status == Status.completed) {
            Either<PostDetail, Failure> _post = model.postDetail;

            return _post.fold((left) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.lightGreen,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildItem(context, left.id.toString(), "Post ID : "),
                      ..._buildItem(
                          context, left.userId.toString(), "User ID : "),
                      ..._buildItem(context, left.title, "Title : "),
                      ..._buildItem(context, left.body, "Description : "),
                    ],
                  ),
                ),
              );
            },
                (right) => Center(
                      child: Text(right.message),
                    ));
          }

          return const Center(child: Text("Something Went Wrong In UI "));
        },
      ),
    );
  }

  List<Widget> _buildItem(BuildContext context, String body, String title) {
    return [
      const SizedBox(
        height: 10,
      ),
      Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        body,
        style: Theme.of(context).textTheme.headline3,
      ),
      const SizedBox(
        height: 10,
      ),
    ];
  }
}
