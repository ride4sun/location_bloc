import 'package:location_bloc/extensions/list_extensions.dart';

extension StringExtensions on String {
//  String generateMessageByGender({Gender gender, Message message}) =>
//      Intl.gender(gender.toString(),
//          male: '$this ${message.male}',
//          female: '$this ${message.female}',
//          other: '$this ${message.other}');

  bool validateEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool equalsIgnoreCase(String other) =>
      (this == null && other == null) ||
      (this != null && other != null && toLowerCase() == other.toLowerCase());

  /// Return the string only if the delimiter exists in both ends, otherwise it will return the current string
  String removeSurrounding(String delimiter) {
    final prefix = delimiter;
    final suffix = delimiter;

    if ((length >= prefix.length + suffix.length) &&
        startsWith(prefix) &&
        endsWith(suffix)) {
      return substring(prefix.length, length - suffix.length);
    }
    return this;
  }

  /// Return a bool if the string is null or empty
  bool get isNullOrEmpty => this == null || isEmpty;

  ///  Replace part of string after the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [defaultValue] which defaults to the original string.
  String replaceAfter(String delimiter, String replacement,
      [String defaultValue]) {
    final index = indexOf(delimiter);
    return (index == -1)
        ? defaultValue.isNullOrEmpty ? this : defaultValue
        : replaceRange(index + 1, length, replacement);
  }

  ///
  /// Replace part of string before the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [missingDelimiterValue] which defaults to the original string.
  String replaceBefore(String delimiter, String replacement,
      [String defaultValue]) {
    final index = indexOf(delimiter);
    return (index == -1)
        ? defaultValue.isNullOrEmpty ? this : defaultValue
        : replaceRange(0, index, replacement);
  }

  /// Count the number of occurrences of delimiter.
  int countOccurrences(Pattern delimiter) {
    int i = 0;
    this.splitMapJoin(delimiter,
        onMatch: (m) {
          i++;
          return '';
        },
        onNonMatch: (n) => '');
    return i;
  }

  /// Return the number of characters after each occurrence of the delimiter
  /// e.g. 000111178965611168264824 with [numberOfCharacters] = '5'
  /// and [delimiter] = '111'
  /// returns '89656', '68264' as a result
  List<String> getCharactersAfter(Pattern delimiter, [int numberOfCharacters]) {
    if (numberOfCharacters.isNotNull) if (this.length < numberOfCharacters ||
        numberOfCharacters < 0) return [];
    return this
        .split(delimiter)
        .dropFirst()
        .map((s) =>
            numberOfCharacters.isNull ? s : s.substring(0, numberOfCharacters))
        .toList();
  }

  /// Return the number of characters after each occurrence of the delimiter
  /// e.g. 012340123401234 and [delimiter] = '123' returns '040404'
  String remove(Pattern delimiter) {
    return this.split(delimiter).join();
  }

  /// Return the number of characters after each occurrence of the delimiter
  /// e.g. 7E8064100BE1B30137E9064100881800107EA06410080080010 with [numberOfCharacters] = '6'
  /// and [delimiter] = '4100'
  /// returns '7E806', '7E906' as a result
  List<String> getCharactersBefore(Pattern delimiter,
      [int numberOfCharacters]) {
    if (numberOfCharacters.isNotNull) if (this.length < numberOfCharacters ||
        numberOfCharacters < 0) return [];
    return this
        .split(delimiter)
        .dropLast()
        .map((s) => numberOfCharacters.isNull
            ? s
            : s.substring(s.length - numberOfCharacters))
        .toList();
  }

  /// Removes all leading and trailing zeros like '000102030000' => '10203'
  String removeLeadingAndTrailingZeros() =>
      this.removeLeadingZeros().removeTrailingZeros();

  /// Removes all leading  zeros like '000102030000' => '102030000'
  String removeLeadingZeros() => this.replaceAll(RegExp(r'^0+'), '');

  /// Removes number of leading characters. If the [numberOfCharacters]
  /// is greater than the overall length than and empty string is returned.
  String removeLeadingCharacters(int numberOfCharacters) {
    if (numberOfCharacters > this.length) return '';
    return this.substring(numberOfCharacters, this.length);
  }

  /// removes all trailing zeros like '000102030000' => '00010203'
  String removeTrailingZeros() {
    return this.replaceAll(RegExp(r'0+$'), '');
  }

  ///Returns `true` if at least one element matches the given [predicate].
  /// the [predicate] should have only one character
  bool anyChar(bool predicate(String element)) =>
      split('').any((s) => predicate(s));

  /// Returns the string if it is not `null`, or the empty string otherwise
  String get orEmpty => this ?? "";

// if the string is empty perform an action
  String ifEmpty(Function action) => isEmpty ? action() : this;

  String get lastIndex {
    if (isNullOrEmpty) return "";
    return this[length - 1];
  }

  /// prints to console this text if it's not empty or null
  void printThis() {
    if (isNullOrEmpty) return;
    print(toString());
  }

  /// Parses the string as an double or returns `null` if it is not a number.
  double toDoubleOrNull() => double.tryParse(this);

  /// Parses the string as an int or returns `null` if it is not a number.
  int toIntOrNull() => int.tryParse(this);

  /// Returns a String without white space at all
  /// "hello world" // helloworld
  String removeAllWhiteSpace() => replaceAll(RegExp(r"\s+\b|\b\s"), "");

  /// Returns true if s is neither null, empty nor is solely made of whitespace characters.
  bool get isNotBlank => this != null && trim().isNotEmpty;

  /// Returns a list of chars from a String
  List<String> toCharArray() => isNotBlank ? split('') : [];

  /// Returns a new string in which a specified string is inserted at a specified index position in this instance.
  String insert(int index, String str) =>
      (List<String>.from(this.toCharArray())..insert(index, str)).join();

  /// Indicates whether a specified string is `null`, `empty`, or consists only of `white-space` characters.
  bool get isNullOrWhiteSpace {
    var length = (this?.split('') ?? []).where((x) => x == ' ').length;
    return length == (this?.length ?? 0) || this.isNullOrEmpty;
  }

  /// Get the last  [numberOfCharacters]
  /// For example, in a string with 10 characters, [numberOfCharacters]
  /// of 3 would return the last 3 characters.
  String last([int numberOfCharacters = 1]) =>
      (this?.length ?? 0) < numberOfCharacters
          ? this
          : this.substring(this.length - numberOfCharacters);

  /// Drop's the last  [numberOfCharacters]
  /// For example, in a string with 10 characters, [numberOfCharacters]
  /// of 3 would return the last 7 characters from the front of the string.
  String dropLast([int numberOfCharacters = 1]) =>
      (this?.length ?? 0) < numberOfCharacters
          ? this
          : this.substring(0, this.length - numberOfCharacters);

  /// Get the first [numberOfCharacters] in length, from the start.
  /// For example, in a string with 10 characters, [numberOfCharacters]
  /// of 3 would return the first 3 characters.
  String first(int numberOfCharacters) =>
      (this?.length ?? 0) < numberOfCharacters
          ? this
          : this.substring(0, numberOfCharacters);

  /// Drop's the first [numberOfCharacters] in length, from the start.
  /// For example, in a string with 10 characters, [numberOfCharacters]
  /// of 3 would return the first 7 characters from the end.
  String dropFirst(int numberOfCharacters) =>
      (this?.length ?? 0) < numberOfCharacters
          ? this
          : this.substring(numberOfCharacters, this.length);

  /// Convert this string into boolean.
  ///
  /// Returns `true` if this string is any of these values: `"true"`, `"yes"`, `"1"`, or if the string is a number and greater than 0, `false` if less than 1. This is also case insensitive.
  bool get asBool {
    var s = this.trim().toLowerCase();
    num n;
    try {
      n = num.parse(s);
    } catch (e) {
      n = -1;
    }
    return s == 'true' || s == 'yes' || n > 0;
  }
}

extension TextUtilsStringExtension on String {
  /// Returns true if string is:
  /// - null
  /// - empty
  /// - whitespace string.
  ///
  /// Characters considered "whitespace" are listed [here](https://stackoverflow.com/a/59826129/10830091).
  bool get isNullEmptyOrWhitespace =>
      this == null || this.isEmpty || this.trim().isEmpty;
}

/// - [isNullOrEmpty], [isNullEmptyOrFalse], [isNullEmptyZeroOrFalse] are from [this StackOverflow answer](https://stackoverflow.com/a/59826129/10830091)
extension GeneralUtilsObjectExtension on Object {
  /// Returns true if object is:
  /// - null `Object`
  bool get isNull => this == null;

  /// Returns true if object is NOT:
  /// - null `Object`
  bool get isNotNull => this != null;

  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  bool get isNullOrEmpty =>
      isNull || _isStringObjectEmpty || _isIterableObjectEmpty;

  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  /// - false `bool`
  bool get isNullEmptyOrFalse =>
      isNull ||
      _isStringObjectEmpty ||
      _isIterableObjectEmpty ||
      _isBoolObjectFalse;

  /// Returns true if object is:
  /// - not null `Object` AND
  /// - not empty `String`
  bool get isNotNullOrEmpty => !isNull && !_isStringObjectEmpty;

  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  /// - false `bool`
  /// - zero `num`
  bool get isNullEmptyFalseOrZero =>
      isNull ||
      _isStringObjectEmpty ||
      _isIterableObjectEmpty ||
      _isBoolObjectFalse ||
      _isNumObjectZero;

  // ------- PRIVATE EXTENSION HELPERS -------
  /// **Private helper**
  ///
  /// If `String` object, return String's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `String`
  bool get _isStringObjectEmpty =>
      (this is String) ? (this as String).isEmpty : false;

  /// **Private helper**
  ///
  /// If `Iterable` object, return Iterable's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `Iterable`
  bool get _isIterableObjectEmpty =>
      (this is Iterable) ? (this as Iterable).isEmpty : false;

  /// **Private helper**
  ///
  /// If `bool` object, return `isFalse` expression
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `bool`
  bool get _isBoolObjectFalse =>
      (this is bool) ? (this as bool) == false : false;

  /// **Private helper**
  ///
  /// If `num` object, return `isZero` expression
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `num`
  bool get _isNumObjectZero => (this is num) ? (this as num) == 0 : false;
}
