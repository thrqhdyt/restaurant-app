import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/utils/result_state.dart';

class AddReviewRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? restaurantId;
  String? name;
  String? reviews;
  bool? loading;

  AddReviewRestaurantProvider(
      {required this.apiService, required this.restaurantId});

  ResultState<Review> _state =
      ResultState(status: Status.loading, message: null, data: null);

  ResultState<Review> get state => _state;

  updateName(String value) {
    name = value;
    notifyListeners();
  }

  updateReviews(String value) {
    reviews = value;
    notifyListeners();
  }

  updateLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<dynamic> postAddReview(String restaurantId) async {
    try {
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      updateLoading(true);
      final respReview =
          await apiService.postReviews(restaurantId, name!, reviews!);
      // ignore: unnecessary_null_comparison
      if (respReview == null) {
        _state = ResultState(
            status: Status.noData, message: 'Empty Data', data: null);
        updateLoading(false);
        notifyListeners();
        return _state;
      } else {
        _state = ResultState(
            status: Status.hasData, message: null, data: respReview);
        updateLoading(false);
        notifyListeners();
        return _state;
      }
    } catch (e) {
      _state = ResultState(
          status: Status.error, message: 'Error --> $e', data: null);
      notifyListeners();
      return _state;
    }
  }
}
