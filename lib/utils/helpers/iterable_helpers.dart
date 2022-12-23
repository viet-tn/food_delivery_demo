extension IterableExt on Iterable {
  T? findFirstElement<T>(bool Function(T element) test) {
    try {
      return firstWhere((element) => test(element));
    } catch (e) {
      return null;
    }
  }
}
