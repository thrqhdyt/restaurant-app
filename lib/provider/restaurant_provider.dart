import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  String query;

  RestaurantProvider({required this.apiService, this.query = ''}) {
    _fetchAllRestaurant(query);
  }

  ResultState<dynamic> _state =
      ResultState(status: Status.loading, message: null, data: null);

  ResultState<dynamic> get state => _state;

  Future<dynamic> _fetchAllRestaurant(query) async {
    try {
      _state = ResultState(status: Status.loading, message: null, data: null);
      notifyListeners();
      if (query == '') {
        final restaurant = await apiService.listRestaurant();
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState(
              status: Status.noData, message: 'Empty Data', data: null);
          notifyListeners();
          return _state;
        } else {
          _state = ResultState(
              status: Status.hasData, message: null, data: restaurant);
          notifyListeners();
          return _state;
        }
      } else {
        final restaurant = await apiService.searchRestaurant(query);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState(
              status: Status.noData, message: 'Empty Data', data: null);
          notifyListeners();
          return _state;
        } else {
          _state = ResultState(
              status: Status.hasData, message: null, data: restaurant);
          notifyListeners();
          return _state;
        }
      }
    } catch (e) {
      _state =
          ResultState(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }

  setQuerySearch(String value) async {
    query = value;
    await _fetchAllRestaurant(query);
    notifyListeners();
  }
}
