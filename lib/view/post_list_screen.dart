import 'package:assignment1_provider/models/post/post.dart';
import 'package:assignment1_provider/utils/app_urls.dart';
import 'package:assignment1_provider/utils/status.dart';
import 'package:assignment1_provider/view_model/post_detail_vm.dart';
import 'package:assignment1_provider/view_model/post_list_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostListViewModel>(context, listen: false).getPostLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Post List Screen",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body:
          Consumer(builder: (BuildContext context, PostListViewModel model, _) {
        if (model.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (model.status == Status.completed) {
          return model.posts.fold((left) {
            return ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: left.length,
                itemBuilder: (ctx, index) {
                  Post _post = left[index];
                  return buildTile(context, _post);
                });
          }, (right) => Center(child: Text(right.message)));
        }
        return const Text("Something went wrong from UI");
      }),
    );
  }

  Widget buildTile(BuildContext context, Post _post) {
    return GestureDetector(
      onTap: () {
        Provider.of<PostListViewModel>(context, listen: false)
            .setSelectedPostId(_post.id);
        Navigator.pushNamed(context, AppUrls.detail);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextRow(context, _post.id.toString(), "Post ID : "),
            const SizedBox(
              height: 8,
            ),
            _buildTextRow(context, _post.userId.toString(), "User ID : "),
            const SizedBox(
              height: 8,
            ),
            _buildTextRow(context, _post.title, "Title : "),
            const SizedBox(
              height: 8,
            ),
            _buildTextRow(context, _post.body, "Body : "),
          ],
        ),
      ),
    );
  }

  Row _buildTextRow(BuildContext context, String body, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Flexible(
          child: Text(body,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline3),
        ),
      ],
    );
  }
}
