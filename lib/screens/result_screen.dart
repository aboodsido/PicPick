import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image_provider.dart';

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
            _buildResultCard(
              context: context,
              label: 'Likes',
              count: imageProvider.likes,
              color: Colors.green,
            ),
            const SizedBox(height: 20),

            // Dislikes
            _buildResultCard(
              context: context,
              label: 'Dislikes',
              count: imageProvider.dislikes,
              color: Colors.red,
            ),
            const SizedBox(height: 20),

            // Optional: A button to go back to the home screen and swipe again
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the HomeScreen
              },
              child: const Text('Go Back and Swipe Again'),
            ),
            ElevatedButton(
              onPressed: () {
                imageProvider.reset(); // Go back to the HomeScreen
              },
              child: const Text('Reset The counts'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build result card
  Widget _buildResultCard({
    required BuildContext context,
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 10),
          Text(
            '$count',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
