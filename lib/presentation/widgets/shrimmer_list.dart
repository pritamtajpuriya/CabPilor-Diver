import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/app_decoration.dart';

class Shrimmer extends StatelessWidget {
  const Shrimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ...List.generate(
            4,
            (index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    height: 90,
                    child: Container(
                      decoration: AppDecoration.outlineBlack9001e
                          .copyWith(borderRadius: BorderRadius.circular(10)),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //notice image

                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),

                              const SizedBox(
                                width: 16,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //notice title
                                    Container(
                                      height: 12,
                                      width: double.infinity,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    //notice description
                                    Container(
                                      height: 10,
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(right: 40),
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      height: 10,
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(right: 100),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
      ],
    );
  }
}
