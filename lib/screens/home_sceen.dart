import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

import '../providers/image_provider.dart';
import '../widgets/image_card.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLike = false;
  bool _showDislike = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ImageProviderClass>(context, listen: false).fetchImages();
    });
  }

  void _showReaction(CardSwiperDirection direction) {
    setState(() {
      if (direction == CardSwiperDirection.right) {
        _showLike = true;
      } else if (direction == CardSwiperDirection.left) {
        _showDislike = true;
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _showLike = false;
        _showDislike = false;
      });
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

          return Stack(
            alignment: Alignment.center,
            children: [
              CardSwiper(
                cardsCount: imageProvider.imageUrls.length,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  return ImageCard(
                      imageUrl: imageProvider.imageUrls[index].imageUrl);
                },
                allowedSwipeDirection:
                    const AllowedSwipeDirection.only(left: true, right: true),
                onSwipe: (previousIndex, currentIndex, direction) {
                  checkDirection(direction, imageProvider, currentIndex);
                  return true;
                },
                onEnd: () {
                  if (!imageProvider.isLoading) {
                    imageProvider.loadNextPage();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResultScreen()),
                  );
                },
              ),

              // Like Animation
              AnimatedOpacity(
                opacity: _showLike ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 100,
                ),
              ),

              // Dislike Animation
              AnimatedOpacity(
                opacity: _showDislike ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.thumb_down,
                  color: Colors.blue,
                  size: 100,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void checkDirection(CardSwiperDirection direction,
      ImageProviderClass imageProvider, int? currentIndex) {
    if (direction == CardSwiperDirection.left) {
      imageProvider
          .dislikeImage(imageProvider.imageUrls[currentIndex!].imageUrl);
      _showReaction(direction);
    } else if (direction == CardSwiperDirection.right) {
      imageProvider.likeImage(imageProvider.imageUrls[currentIndex!].imageUrl);
      _showReaction(direction);
    }
  }
}
