import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/add_review_restaurant.dart';

class AddReview extends StatelessWidget {
  final String restaurantId;

  const AddReview({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddReviewRestaurantProvider>(
      create: (_) => AddReviewRestaurantProvider(
          apiService: ApiService(), restaurantId: restaurantId),
      child: Consumer<AddReviewRestaurantProvider>(
        builder: (context, state, _) {
          final provider = Provider.of<AddReviewRestaurantProvider>(context);

          return SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Review",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Your Name",
                        ),
                        onChanged: (value) {
                          provider.updateName(value);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Reviews",
                        ),
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          provider.updateReviews(value);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider
                              .postAddReview(restaurantId)
                              .whenComplete(() => Navigator.pop(context));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent),
                        child: const Text("Submit"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
