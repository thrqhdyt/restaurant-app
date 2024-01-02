import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResult> listRestaurant(http.Client client) async {
    final response = await client.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurant> detailRestaurant(
      String id, http.Client client) async {
    final response = await client.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchRestaurant> searchRestaurant(query, http.Client client) async {
    final response = await client.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<Review> postReviews(String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {'id': id, 'name': name, 'review': review},
      ),
    );
    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
