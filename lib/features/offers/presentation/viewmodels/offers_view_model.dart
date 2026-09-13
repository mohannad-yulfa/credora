import 'package:flutter/foundation.dart';
import '../../domain/entities/offer_entities.dart';
import '../../domain/usecases/get_offers.dart';

class OffersViewModel extends ChangeNotifier {
  final GetOffers? _getOffers;
  OffersViewModel([this._getOffers]);

  bool isLoading = false;
  String? errorMessage;
  List<OfferData> offers = [];

  Future<void> loadOffers() async {
    if (_getOffers == null) return;
    isLoading = true; errorMessage = null; notifyListeners();
    try { offers = await _getOffers!.call(); } catch (e) { errorMessage = e.toString(); }
    isLoading = false; notifyListeners();
  }
}
