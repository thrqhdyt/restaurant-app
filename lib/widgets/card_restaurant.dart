import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurants;

  const CardRestaurant({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routenName,
              arguments: restaurants.id);
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Hero(
                tag: restaurants.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 120.0,
                    child: FadeInImage(
                      placeholder: const AssetImage(
                          'assets/growing_ring.gif'), // Placeholder image
                      image: NetworkImage(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}'),
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    restaurants.name,
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
                          Text(restaurants.city),
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
                          Text("${restaurants.rating}"),
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
}
