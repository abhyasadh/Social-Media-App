import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/app_theme.dart';

class PostShimmer extends ConsumerWidget {
  final int count;
  final ScrollController? controller;

  const PostShimmer({required this.count, this.controller, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shimmer = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 200,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 20,
                        height: 10,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.75,
          color: Colors.white,
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: 200,
          height: 40,
          color: Colors.white,
          margin: const EdgeInsets.only(left: 14),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: 100,
          height: 20,
          color: Colors.white,
          margin: const EdgeInsets.only(left: 14),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 32,
          color: Colors.white,
          margin: const EdgeInsets.only(
              left: 14, right: 14, bottom: 14),
        ),
      ],
    );

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: count == 1
          ? shimmer
          : ListView.separated(
              itemCount: count,
              controller: controller ?? ScrollController(),
              itemBuilder: (context, index) {
                return shimmer;
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 6,
                  width: MediaQuery.of(context).size.width,
                  color: AppTheme.primaryColor.withOpacity(0.2),
                );
              },
            ),
    );
  }
}
