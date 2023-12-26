import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/widgets/network_error.dart';
import 'package:restaurant_app/widgets/result_not_found.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/home_screen';
  final controller = TextEditingController();

  RestaurantListPage({super.key});

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
                        text: "Recommendation restaurant for you!",
                        style: Theme.of(context).textTheme.titleSmall)
                  ]),
                ),
                titlePadding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              ),
            )
          ];
        },
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    leading: const Icon(Icons.search),
                    hintText: "Search...",
                    onChanged: (value) {
                      Provider.of<RestaurantProvider>(context, listen: false)
                          .setQuerySearch(value);
                    })),
            Expanded(
              child: Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  ResultState<dynamic> resultState = state.state;
                  switch (resultState.status) {
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator());
                    case Status.hasData:
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: resultState.data.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurants =
                              resultState.data!.restaurants[index];
                          return CardRestaurant(restaurants: restaurants);
                        },
                      );
                    case Status.noData:
                      return const Center(
                        child: ResultNotFound(),
                      );
                    case Status.error:
                      return const Center(
                        child: NetworkError(),
                      );
                    default:
                      return const Center(
                        child: ErrorMessage(),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
