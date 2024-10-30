import "package:perpus/models/book.dart";


class BookController {
  final List<BookModel> books = [
    BookModel(
      id: 1,
      title: "jakarta sebelum pagi",
      author: "ziggy",
      publisher: "ndatau",
      synopsis: "....",
      coverImagePath: "assets/jakartasebelumpagi.jpg",
      stock: 12,
    ),
    BookModel(
      id: 2,
      title: "hujan",
      author: "tisha",
      publisher: "mcd",
      synopsis: "...",
      coverImagePath: "assets/hujan.jpg",
      stock: 10,
    ),
  ];
}
