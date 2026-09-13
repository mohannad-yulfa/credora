import '../entities/offer_entities.dart';

abstract interface class OffersRepository {
  Future<List<OfferData>> getOffers();
}
