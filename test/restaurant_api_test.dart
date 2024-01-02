import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

void main() {
  group('Restaurant API Testing', () {
    test('Should return a list of restaurant', () async {
      final mockClient = MockClient((request) async {
        final response = {
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": []
        };
        return Response(jsonEncode(response), 200);
      });
      expect(
        await ApiService().listRestaurant(mockClient),
        isA<RestaurantResult>(),
      );
    });

    test(
      'should return result a restaurant search',
      () async {
        final mockClient = MockClient(
          (request) async {
            final response = {"error": false, "founded": 1, "restaurants": []};
            return Response(jsonEncode(response), 200);
          },
        );

        expect(
          await ApiService().searchRestaurant('RestaurantName', mockClient),
          isA<SearchRestaurant>(),
        );
      },
    );

    test("should return a Detail of Restaurant", () async {
      final mockClient = MockClient((request) async {
        final response = {
          "error": false,
          "message": "success",
          "restaurant": {
            "id": "",
            "name": "",
            "description": "",
            "city": "",
            "address": "",
            "pictureId": "",
            "categories": [],
            "menus": {"foods": [], "drinks": []},
            "rating": 1.0,
            "customerReviews": [],
          },
        };
        return Response(jsonEncode(response), 200);
      });

      expect(
        await ApiService().detailRestaurant('Restaurant Id', mockClient),
        isA<DetailRestaurant>(),
      );
    });
  });
}
