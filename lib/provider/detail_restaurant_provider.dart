import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  ResultState<DetailRestaurant> _state =
      ResultState(status: Status.loading, message: null, data: null);

  ResultState<DetailRestaurant> get state => _state;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      // ignore: unnecessary_null_comparison
      if (detailRestaurant.restaurant == null) {
        _state = ResultState(
            status: Status.noData, message: 'Empty Data', data: null);
        notifyListeners();
        return _state;
      } else {
        _state = ResultState(
            status: Status.hasData, message: null, data: detailRestaurant);
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
