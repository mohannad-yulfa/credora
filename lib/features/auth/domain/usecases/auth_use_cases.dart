import '../repositories/auth_repository.dart';

/// Domain entry point for authentication use cases.
/// The current supplied lib contains navigation/UI only, so no behavior is invented here.
class AuthUseCases {
  final AuthRepository repository;
  const AuthUseCases(this.repository);
}
