extension MapExt<K, V> on Map<K, V> {
  Map<K, V> removeNull() => Map<K, V>.fromEntries(entries.where((element) => element.value != null));
}
