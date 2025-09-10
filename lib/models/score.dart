class Score {
  final int points;
  final DateTime date;

  Score({required this.points, required this.date});

  Map<String, dynamic> toMap() {
    final formattedDate = "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";

    return {
      'points': points,
      'date': formattedDate,
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      points: map['points'],
      date: DateTime.parse(map['date']),
    );
  }

  String get formattedDate {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day.$month.$year';
  }
}
