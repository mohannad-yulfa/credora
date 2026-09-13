import '../entities/offer_entities.dart';
import '../repositories/offers_repository.dart';

class GetOffers {
  final OffersRepository repository;
  const GetOffers(this.repository);

  Future<List<OfferData>> call() => repository.getOffers();
}
