class QuoteModal {
  late List<Results> results;

  QuoteModal({required this.results});

  factory QuoteModal.fromMap(Map m1) {
    return QuoteModal(
        results: (m1['results'] as List).map((e) => Results.fromMap(e),).toList());
  }
}

class Results {
  late String content, author;
  late List tags;

  Results({
    required this.content,
    required this.author,
    required this.tags,
  });

  factory Results.fromMap(Map m1) {
    return Results(
        content: m1['content'], author: m1['author'], tags: m1['tags'] ?? '');
  }
}
