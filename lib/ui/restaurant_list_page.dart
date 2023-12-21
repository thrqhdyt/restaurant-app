import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/widgets/result_not_found.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final controller = TextEditingController();
  List<Restaurant> allRestaurants = [];
  List<Restaurant> displayedRestaurants = [];

  bool loadingError = false;
  String errorMessage = '';

  Future<void> loadRestaurants() async {
    try {
      final jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json');
      final List<Restaurant> restaurants = parseRestaurants(jsonString);
      setState(() {
        allRestaurants = restaurants;
        displayedRestaurants = allRestaurants;
        loadingError = false;
      });
    } catch (e) {
      setState(() {
        loadingError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

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
                  onChanged: searchRestaurantByName,
                )),
            loadingError
                ? const ErrorMessage()
                : displayedRestaurants.isEmpty
                    ? const ResultNotFound()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: displayedRestaurants.length,
                          itemBuilder: (context, index) {
                            return _buildRestaurantItem(
                                context, displayedRestaurants[index]);
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routenName,
              arguments: restaurant);
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 120.0,
                    child: FadeInImage(
                      placeholder: const AssetImage(
                          'assets/growing_ring.gif'), // Placeholder image
                      image: NetworkImage(restaurant.pictureId),
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    restaurant.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 16.0,
                          ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(restaurant.city),
                        ],
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18.0,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text("${restaurant.rating}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchRestaurantByName(String query) {
    setState(() {
      displayedRestaurants = allRestaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
