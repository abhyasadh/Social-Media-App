import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/app_theme.dart';

class JobShimmer extends ConsumerWidget {
  final int count;
  final ScrollController? controller;

  const JobShimmer({required this.count, this.controller, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shimmer = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          width: 200,
          color: Colors.white,
          margin: const EdgeInsets.all(14),
        ),
        Container(
          height: 100,
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
