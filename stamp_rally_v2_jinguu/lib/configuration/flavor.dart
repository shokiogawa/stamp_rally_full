enum FlavorType {
  develop,
  production;

  static FlavorType getFromString(String flavorString) =>
      switch (flavorString) {
        'develop' => FlavorType.develop,
        'production' => FlavorType.production,
        _ => throw Exception('Unknown flavor string: $flavorString'),
      };

  static FlavorType get environment {
    const flavor = String.fromEnvironment('flavor');
    if (flavor == 'dev') {
      return FlavorType.develop;
    } else if (flavor == 'prod') {
      return FlavorType.production;
    }
    throw AssertionError('No support flavor');
  }
}
