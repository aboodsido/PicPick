import 'package:flutter/material.dart';

import '../models/image_model.dart';
import '../services/api_service.dart';

class ImageProviderClass extends ChangeNotifier {
  final ImageService _imageService = ImageService();
  List<ImageModel> _imageUrls = [];
  bool _isLoading = true;
  var _currentPage = 1;

  

  List<ImageModel> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;

  // Fetch images and update the state
  Future<void> fetchImages({int page = 1}) async {
    try {
      _isLoading = true;
      notifyListeners(); // Notify listeners before fetching

      _imageUrls = await _imageService.fetchImages(page: page);
      _isLoading = false;
      notifyListeners(); // Notify listeners after data is fetched
    } catch (e) {
      _isLoading = false;
      notifyListeners(); // Notify listeners in case of an error
      print('Error fetching images: $e');
    }
  }

   void loadNextPage() {
    _currentPage++;
    fetchImages(page: _currentPage);
  }
}
