part of 'blog_cubit.dart';

class BlogState {
  StateStatusEnum getBlogStatus;
  List<Blog> blogList;
  String getBlogError;
  BlogState({
    this.getBlogStatus = StateStatusEnum.initial,
    this.getBlogError = '',
    this.blogList = const [],
  });
  BlogState copyWith({
    StateStatusEnum? getBlogStatus,
    String? getBlogError,
    List<Blog>? blogList,
  }) {
    return BlogState(
      getBlogStatus: getBlogStatus ?? this.getBlogStatus,
      getBlogError: getBlogError ?? this.getBlogError,
      blogList: blogList ?? this.blogList,
    );
  }
}
