import 'package:flutter/foundation.dart';

/// ViewModel boundary for Referrals.
///
/// The original screen is intentionally kept behaviorally identical.
/// Move non-visual state and commands here incrementally without changing the
/// public screen API or its navigation contract.
class ReferralsViewViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _errorMessage = value;
    notifyListeners();
  }
}
