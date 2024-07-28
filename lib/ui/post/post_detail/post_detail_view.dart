// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/post/post_detail/post_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class PostDetailView extends StatelessWidget {
  final String postId;
  const PostDetailView({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailViewModel>.reactive(
      viewModelBuilder: () => PostDetailViewModel(),
      onModelReady: (model) => model.init(postId),
      builder: (context, model, widget) => const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text("Example Page"),
            ),
          ),
        ),
      ),
    );
  }
}
