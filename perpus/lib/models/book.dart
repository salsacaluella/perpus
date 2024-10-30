class BookModel {
  int id;
  String title;
  String author;
  String publisher;
  String synopsis;
  String coverImagePath;
  int stock;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.synopsis,
    required this.coverImagePath,
    required this.stock,
  });
}
