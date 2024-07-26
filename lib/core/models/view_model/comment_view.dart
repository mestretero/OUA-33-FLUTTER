import 'package:oua_flutter33/core/models/comment_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class CommentView {
  final User user;
  final Comment comment;

  CommentView({
    required this.user,
    required this.comment,
  });
}
