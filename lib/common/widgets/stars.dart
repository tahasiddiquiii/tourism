import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tourism/constants/global_variables.dart';

class Stars extends StatelessWidget {
  final double rating;
  final double itemSize;

  const Stars({
    super.key,
    required this.rating,
    required this.itemSize,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        direction: Axis.horizontal,
        itemCount: 5,
        rating: rating,
        itemSize: itemSize,
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: GlobalVariables.selectedNavBarColor,
            ),
        unratedColor: Colors.grey[300]);
  }
}
