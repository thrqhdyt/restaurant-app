import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/add_review.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/widgets/network_error.dart';
import '../widgets/card_review.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routenName = '/restaurant_detail';
  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      DetailRestaurantProvider detailProvider =
          Provider.of<DetailRestaurantProvider>(context, listen: false);
      detailProvider.fetchDetailRestaurant(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        ResultState<DetailRestaurant> resultState = state.state;
        switch (resultState.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.hasData:
            var detailRestaurant = resultState.data?.restaurant;
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      expandedHeight: 250,
                      title: Text(
                        detailRestaurant.name,
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag: detailRestaurant.pictureId,
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/large/${detailRestaurant.pictureId}',
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
                              detailRestaurant!.name,
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
                                    "${detailRestaurant.rating}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                              detailRestaurant.city,
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
                        Text(detailRestaurant.description,
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
                                        detailRestaurant
                                            .menus.foods[index].name,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: detailRestaurant.menus.foods.length,
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
                                        detailRestaurant
                                            .menus.drinks[index].name,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: detailRestaurant.menus.drinks.length,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          "Reviews",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var review =
                                  detailRestaurant.customerReviews[index];
                              return CardReview(review: review);
                            },
                            itemCount: detailRestaurant.customerReviews.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: SizedBox(
                width: 200,
                height: 45,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AddReview(
                          restaurantId: detailRestaurant.id.toString()),
                    ).then((value) {
                      Provider.of<DetailRestaurantProvider>(context,
                              listen: false)
                          .fetchDetailRestaurant(widget.restaurantId);
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Review"),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          case Status.noData:
            return const Material(
              child: Center(
                child: ErrorMessage(),
              ),
            );
          case Status.error:
            return const Material(
              child: Center(
                child: NetworkError(),
              ),
            );
          default:
            return const Material(
              child: Center(
                child: ErrorMessage(),
              ),
            );
        }
      },
    );
  }
}
