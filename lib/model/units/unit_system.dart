enum UnitSystem { Metrics, SAE }

UnitSystem fromUnitString(String unit) =>
    UnitSystem.values.firstWhere((e) => e.toString() == unit);

UnitSystem fromUnitStringEnumValue(String unit) =>
    UnitSystem.values.firstWhere((e) => e.toString().split('.').last == unit);

List<String> getUnitStrings() =>
    UnitSystem.values.map((v) => v.toString().split('.').last).toList();
