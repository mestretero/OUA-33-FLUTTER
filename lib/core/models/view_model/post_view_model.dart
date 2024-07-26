import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/comment_view.dart';

class PostViewModel {
  final User? user;
  final Post post;
  final List<CommentView> comments;
  final List<PepoleWhoLike> peopleWhoLike;

  PostViewModel({
    this.user,
    required this.post,
    required this.comments,
    required this.peopleWhoLike,
  });
}
