import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perpus/controllers/book_controller.dart';
import 'package:perpus/models/book.dart';
import 'package:perpus/widget/modal.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  final formKey = GlobalKey<FormState>();
  final BookController bookController = BookController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController synopsisController = TextEditingController();
  final TextEditingController coverImageController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  List<String> categories = ["Fiction", "Non-Fiction", "Comics", "Biography"];
  int selectedCategoryIndex = 0;
  List<BookModel>? books;
  int? editingBookIndex;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() {
    setState(() {
      books = bookController.books;
    });
  }

  void selectCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  void openAddEditModal({BookModel? book, int? index}) {
    if (book != null) {
      setState(() {
        editingBookIndex = index;
      });

      titleController.text = book.title;
      authorController.text = book.author;
      publisherController.text = book.publisher;
      synopsisController.text = book.synopsis;
      coverImageController.text = book.coverImagePath;
      stockController.text = book.stock.toString();
    } else {
      setState(() {
        editingBookIndex = null;
      });

      titleController.clear();
      authorController.clear();
      publisherController.clear();
      synopsisController.clear();
      coverImageController.clear();
      stockController.clear();
    }

    ModalWidget().showFullModal(context, buildAddEditForm());
  }

  Widget buildAddEditForm() {
    return ModalWidget().buildAddEditForm(
      formKey: formKey,
      titleController: titleController,
      authorController: authorController,
      publisherController: publisherController,
      synopsisController: synopsisController,
      coverImagePathController: coverImageController,
      stockController: stockController,
      onSave: () {
        if (formKey.currentState!.validate()) {
          final newBook = BookModel(
            id: books!.length + 1,
            title: titleController.text,
            author: authorController.text,
            publisher: publisherController.text,
            synopsis: synopsisController.text,
            coverImagePath: coverImageController.text,
            stock: int.parse(stockController.text),
          );

          setState(() {
            if (editingBookIndex != null) {
              books![editingBookIndex!] = newBook;
            } else {
              books!.add(newBook);
            }
            fetchBooks();
          });
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu, color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => openAddEditModal(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Discover your next book",
              style: GoogleFonts.bebasNeue(fontSize: 56, color: Colors.white),
            ),
          ),
          SizedBox(height: 25),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search for books...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),

          // Category list
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => selectCategory(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.only(left: 25),
                    decoration: BoxDecoration(
                      color: selectedCategoryIndex == index
                          ? Colors.tealAccent
                          : Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategoryIndex == index
                              ? Colors.black
                              : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 25),

          // Book list
          Expanded(
            child: GridView.builder(
              itemCount: books!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //jumlah max buku per baris
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 25,
                  childAspectRatio: 0.6),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      openAddEditModal(book: books![index], index: index),
                  child: Container(
                    margin: EdgeInsets.only(left: 25, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book cover
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(books![index].coverImagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        // Book title
                        Text(
                          books![index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),

                        // Book author
                        Text(
                          books![index].author,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
