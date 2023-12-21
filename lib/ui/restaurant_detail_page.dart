import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routenName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 250,
              title: Text(
                restaurant.name,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    restaurant.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 24.0,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            "${restaurant.rating}",
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    Text(
                      restaurant.city,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Description : ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(restaurant.description,
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 28.0,
                ),
                const Text("Foods Menu : ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 4.0, top: 4.0, bottom: 4.0),
                        child: Card(
                          child: Container(
                            width: 160,
                            alignment: Alignment.bottomLeft,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/foods.png'),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0,
                                  top: 8.0,
                                  right: 8.0,
                                  bottom: 8.0),
                              child: Text(
                                restaurant.menus.foods[index].name,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: restaurant.menus.foods.length,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Drinks Menu : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 4.0, top: 4.0, bottom: 4.0),
                        child: Card(
                          child: Container(
                            width: 160,
                            alignment: Alignment.bottomLeft,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/drinks.png'),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0,
                                  top: 8.0,
                                  right: 8.0,
                                  bottom: 8.0),
                              child: Text(
                                restaurant.menus.drinks[index].name,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: restaurant.menus.drinks.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
