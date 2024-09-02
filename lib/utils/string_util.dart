String extractFirstTwoWords(String sentence) {
  List<String> words = sentence.split(' ');
  if (words.length >= 2) {
    String result = words.take(2).join(' ');
    return toTitleCase(result);
  } else {
    return toTitleCase(sentence); // Return the original sentence in title case if it has less than 2 words
  }
}

String toTitleCase(String text) {
  return text.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}