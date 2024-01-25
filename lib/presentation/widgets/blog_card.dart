import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:readmock/domain/model/blog.dart';

import '../../constant/globals.dart';
import '../pages/blog/blog_details_screen.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => BlogDetailsScreen(
                  blog: blog,
                )));
      },
      child: Hero(
        tag: blog.id!,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: CachedNetworkImage(
                    alignment: Alignment.center,
                    height: 100,
                    imageUrl: Globals.imagePath + blog.image!,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                  ),
                ),
                Divider(),
                Text(blog.title!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                SizedBox(
                  height: 4,
                ),
                HtmlWidget(
                  blog.description!.length > 100
                      ? blog.description!.substring(0, 40) + "..."
                      : blog.description!,
                  textStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
