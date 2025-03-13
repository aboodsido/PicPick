import 'package:flutter/material.dart';
import 'package:get/get_common/get_reset.dart';

import '../models/image_model.dart';
import '../services/api_service.dart';

class ImageProviderClass extends ChangeNotifier {
  final ImageService _imageService = ImageService();

  List<ImageModel> _imageUrls = []; // Holds the list of images
  bool _isLoading = false;
  int _currentPage = 1; // Keeps track of the current page for pagination
  int _likes = 0; // Track the number of likes
  int _dislikes = 0; // Track the number of dislikes

  // Lists to store liked and disliked images to avoid double counting
  final List<String> _likedImages = [];
  final List<String> _dislikedImages = [];

  List<ImageModel> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  int get likes => _likes;
  int get dislikes => _dislikes;

  // Fetch images from the API, handle pagination
  Future<void> fetchImages({int page = 1}) async {
    try {
      _isLoading = true;
      notifyListeners(); 

      final newImages = await _imageService.fetchImages(page: page);

      if (page == 1) {
        _imageUrls = newImages.take(10).toList();
      } else {
        _imageUrls = newImages.take(10).toList();
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error fetching images: $e');
    }
  }

  // Increment the like count and add image to the liked list
  void likeImage(String imageUrl) {
    if (!_likedImages.contains(imageUrl)) {
      _likes++;
      _likedImages.add(imageUrl);
      notifyListeners();
    }
  }

  // Increment the dislike count and add image to the disliked list
  void dislikeImage(String imageUrl) {
    if (!_dislikedImages.contains(imageUrl)) {
      _dislikes++;
      _dislikedImages.add(imageUrl);
      notifyListeners();
    }
  }

  // Load the next page of images (for pagination)
  void loadNextPage() {
    _currentPage++;
    fetchImages(page: _currentPage);
    notifyListeners();
  }

  void reset() {
    _imageUrls = [];
    _likes = 0;
    _dislikes = 0;
    _likedImages.clear();
    _dislikedImages.clear();
    fetchImages();
  }
}
