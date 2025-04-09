extension MapExt on Map {
  Map removeNull() => Map.fromEntries(entries.where((element) => element.value == null));
}
