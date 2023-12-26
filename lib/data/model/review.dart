import 'package:restaurant_app/data/model/detail_restaurant.dart';

class Review {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  Review({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
