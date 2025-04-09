extension StringExt on String? {
  List<String> extractEmails() {
    final RegExp emailRegex = RegExp(r'[^@\s]+@[^.\s]+\.\S+');

    return emailRegex.allMatches(this ?? '').map((match) => match.group(0)!).toList();
  }

  String getExtensionFileName() {
    if (this == null || !this!.contains('.')) {
      return '';
    }

    final parts = this!.split('.');
    return parts.isNotEmpty ? parts.last.toLowerCase() : '';
  }
}
