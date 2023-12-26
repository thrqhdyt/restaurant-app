import 'package:flutter/material.dart';
import '../data/model/detail_restaurant.dart';

class CardReview extends StatelessWidget {
  const CardReview({
    super.key,
    required this.review,
  });

  final CustomerReview review;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.asset('assets/user.png'),
            title: Text(review.name),
            subtitle: Text(review.date),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 12.0,
            ),
            child: Text(
              review.review,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }
}
