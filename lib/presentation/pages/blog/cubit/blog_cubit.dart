import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readmock/constant/enum.dart';

import '../../../../domain/model/blog.dart';
import '../../../../domain/repository/data_repository.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  DataRepository _dataRepository;
  BlogCubit(this._dataRepository) : super(BlogState());

  void getBlogs() async {
    emit(state.copyWith(getBlogStatus: StateStatusEnum.loading));
    var response = await _dataRepository.getBlog();
    response.fold(
      (l) => emit(state.copyWith(
          getBlogError: l.message, getBlogStatus: StateStatusEnum.error)),
      (r) => emit(
          state.copyWith(blogList: r, getBlogStatus: StateStatusEnum.success)),
    );
  }
}
