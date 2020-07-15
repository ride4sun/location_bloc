extension Take2<T> on List<T> {
  List<R> take2<R>(R Function(T, T) transform) => [
        for (int i = 0; i < this.length - 1; i += 2)
          transform(this[i], this[i + 1]),
      ];
}

extension CollectionsExtensions<T> on Iterable<T> {
  /// Returns a list containing all elements except first [n] elements.
  List<T> dropFirst([int n = 1]) {
    if (n == 0) return [];

    var list = List<T>();
    var originalList = this.toList();
    if (this is Iterable) {
      final resultSize = this.length - n;
      if (resultSize <= 0) return [];
      if (resultSize == 1) return [this.last];

      originalList.removeRange(0, n);

      originalList.forEach((element) => list.add(element));
    }
    return list;
  }

  /// Returns the first element of null if not present (empty list)
  T get firstOrNull {
    if (this.length == 0) return null;
    return this.first;
  }

  /// Returns true is all parameters are equal to [value]
  /// Uses the equal operator which can lead to a reference or deep value equal
  bool allEqualTo(T value) {
    return this.where((e) => e == value).length == this.length;
  }

  /// Returns true if some  parameters are not equal to [value]
  /// Uses the equal operator which can lead to a reference or deep value equal
  bool allNotEqualTo(T value) => !this.allEqualTo(value);

  /// Returns true if object is:
  /// - not null `Object` AND
  /// - not empty `String`
  bool get isNotNullOrEmpty => this != null && this.length != 0;

  /// Returns a list containing all elements except last [n] elements.
  List<T> dropLast([int n = 1]) {
    if (n == 0) return [];

    var list = List<T>();
    var originalList = this.toList();
    if (this is Iterable) {
      final resultSize = this.length - n;
      if (resultSize <= 0) return [];
      if (resultSize == 1) return [this.first];

      originalList.removeRange(this.length - n, this.length);

      originalList.forEach((element) => list.add(element));
    }
    return list;
  }
}
