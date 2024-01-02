import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/empty_data.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  const RestaurantFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              expandedHeight: 150,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Restaurant",
                        style: Theme.of(context).textTheme.titleLarge),
                    const TextSpan(text: "\n"),
                    TextSpan(
                        text: "Your Favorite Restaurant!!",
                        style: Theme.of(context).textTheme.titleSmall)
                  ]),
                ),
                titlePadding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              ),
            )
          ];
        },
        body: Column(children: [
          Expanded(
            child: Consumer<DatabaseProvider>(
              builder: (context, provider, child) {
                ResultState result = provider.state;
                switch (result.status) {
                  case Status.hasData:
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.favorites.length,
                      itemBuilder: (context, index) {
                        var favoriteRestaurant = provider.favorites[index];
                        return CardRestaurant(restaurants: favoriteRestaurant);
                      },
                    );
                  default:
                    return const Center(
                      child: EmptyData(),
                    );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
