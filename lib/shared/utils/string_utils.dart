extension StringUtils on String? {
  List<String> extractEmails() {
    final RegExp emailRegex = RegExp(r'[^@\s]+@[^.\s]+\.\S+');

    return emailRegex.allMatches(this ?? '').map((match) => match.group(0)!).toList();
  }
}
