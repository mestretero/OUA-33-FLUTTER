import 'package:oua_flutter33/core/models/comment_model.dart';
import 'package:oua_flutter33/core/models/post_model.dart';

class PostViewModel {
  final Post post;
  final List<Comment> comments;
  final List<PepoleWhoLike> peopleWhoLike;

  PostViewModel({
    required this.post,
    required this.comments,
    required this.peopleWhoLike,
  });
}
