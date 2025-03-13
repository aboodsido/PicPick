// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

import '../providers/image_provider.dart';
import '../widgets/image_card.dart';
import 'result_screen.dart'; // Reusable widget for image display

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the API call happens after the widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch images after the initial build
      Provider.of<ImageProviderClass>(context, listen: false).fetchImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PicPick'),
        centerTitle: true,
      ),
      body: Consumer<ImageProviderClass>(
        builder: (context, imageProvider, child) {
          if (imageProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (imageProvider.imageUrls.isEmpty) {
            return const Center(child: Text('No images available'));
          }

          return CardSwiper(
            cardsCount: imageProvider.imageUrls.length,
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) {
              return ImageCard(
                  imageUrl: imageProvider.imageUrls[index].imageUrl);
            },
            allowedSwipeDirection:
                const AllowedSwipeDirection.only(left: true, right: true),
            onSwipe: (previousIndex, currentIndex, direction) {
              if (direction == CardSwiperDirection.left) {
                imageProvider.dislikeImage(
                    imageProvider.imageUrls[currentIndex!].imageUrl);
              } else if (direction == CardSwiperDirection.right) {
                imageProvider
                    .likeImage(imageProvider.imageUrls[currentIndex!].imageUrl);
              }
              return true;
            },
            onEnd: () {
              if (!imageProvider.isLoading) {
                imageProvider.loadNextPage();
              }
              // Navigate to ResultScreen when all images are swiped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResultScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
