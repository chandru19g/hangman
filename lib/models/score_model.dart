class Score {
  int? id;
  String scoreDate;
  int userScore;

  Score({
    this.id,
    required this.scoreDate,
    required this.userScore,
  });

  Map<String, dynamic> toMap() {
    return {
      'scoreDate': scoreDate,
      'userScore': userScore,
    };
  }

  @override
  String toString() {
    return '$userScore, $scoreDate, $id';
  }
}
