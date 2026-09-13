class ClickedActivity {
  final String date;
  final String offerName;

  ClickedActivity({required this.date, required this.offerName});
}

class CerditedActivity {
  final String name;
  final String date;
  final String Amount;

  CerditedActivity({
    required this.name,
    required this.date,
    required this.Amount,
  });
}

class PendingActivity {
  final String creditReleaseDate;
  final String Amount;
  final String Action;

  PendingActivity({
    required this.creditReleaseDate,
    required this.Amount,
    required this.Action,
  });
}
