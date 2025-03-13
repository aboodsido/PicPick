import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image_provider.dart';
import '../widgets/result_card_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderClass>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Results'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Heading
            Text(
              'Your Image Swiping Results',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),

            // Likes
            buildResultCard(
              context: context,
              label: 'Likes',
              count: imageProvider.likes,
              color: Colors.green,
            ),
            const SizedBox(height: 20),

            // Dislikes
            buildResultCard(
              context: context,
              label: 'Dislikes',
              count: imageProvider.dislikes,
              color: Colors.red,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back and Swipe Again'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                imageProvider.reset();
              },
              child: const Text('Reset The counts'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build result card
}
