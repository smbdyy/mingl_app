enum ActivityLevel {
  resting('Resting'),
  light('Light'),
  moderate('Moderate'),
  high('High'),
  veryHigh('VeryHigh');

  final String serverValue;

  const ActivityLevel(this.serverValue);
}