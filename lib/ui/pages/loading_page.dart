import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.height, required this.width})
      : super(key: key);

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
