import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/presentation/widgets/blog_card.dart';

import '../../../constant/enum.dart';
import 'cubit/blog_cubit.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Blogs and Articles"),
        ),
        body: BlocBuilder<BlogCubit, BlogState>(builder: (context, state) {
          if (state.getBlogStatus == StateStatusEnum.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.getBlogStatus == StateStatusEnum.error) {
            return Center(
              child: Text(state.getBlogError),
            );
          }
          if (state.getBlogStatus == StateStatusEnum.success) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.75),
                itemCount: state.blogList.length,
                itemBuilder: (context, index) {
                  return BlogCard(blog: state.blogList[index]);
                });
          }
          return Container();
        }));
  }
}
