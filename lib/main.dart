import 'package:assignment1_provider/repository/post/post_detail_repository_implemantation.dart';
import 'package:assignment1_provider/repository/post/post_list_repository_implementation.dart';
import 'package:assignment1_provider/utils/app_urls.dart';
import 'package:assignment1_provider/view/post_detail_screen.dart';
import 'package:assignment1_provider/view/post_list_screen.dart';
import 'package:assignment1_provider/view_model/post_detail_vm.dart';
import 'package:assignment1_provider/view_model/post_list_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PostDetailRepositoryImplementation>(
            create: (_) => PostDetailRepositoryImplementation()),
        Provider<PostListRepositoryImplementation>(
            create: (_) => PostListRepositoryImplementation()),
        ChangeNotifierProxyProvider<PostListRepositoryImplementation,
            PostListViewModel>(
          create: (ctx) => PostListViewModel(),
          update: (BuildContext context,
              PostListRepositoryImplementation postListRepo,
              PostListViewModel? postListViewModel) {
            postListViewModel?.setRepositoryProvider(postListRepo);
            return postListViewModel!;
          },
        ),
        ChangeNotifierProxyProvider2<PostDetailRepositoryImplementation,
            PostListViewModel, PostDetailViewModel>(
          create: (ctx) => PostDetailViewModel(),
          update: (BuildContext context,
              PostDetailRepositoryImplementation postDetailRepo,
              PostListViewModel _postListViewModel,
              PostDetailViewModel? postDetailViewModel) {
            postDetailViewModel?.setRepositoryProvider(postDetailRepo);
            postDetailViewModel?.setPostListViewModel(_postListViewModel);

            return postDetailViewModel!;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "posts",
        theme: ThemeData(
            primaryColor: Colors.orange,
            brightness: Brightness.light,
            primarySwatch: Colors.orange,
            textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              headline2: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              headline3: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87),
            ),
            splashColor: Colors.lightGreen),
        initialRoute: AppUrls.home,
        routes: {
          AppUrls.home: (_) => const PostListScreen(),
          AppUrls.detail: (_) => const PostDetailScreen(),
        },
      ),
    );
  }
}
