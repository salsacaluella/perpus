

import 'package:flutter/material.dart';

class ModalWidget {
  void showFullModal(BuildContext context, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
          ),
          child: content,
        );
      },
    );
  }

  Widget buildAddEditForm({
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController authorController,
    required TextEditingController publisherController,
    required TextEditingController synopsisController,
    required TextEditingController coverImagePathController,
    required TextEditingController stockController,
    required VoidCallback onSave,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: authorController,
              decoration: InputDecoration(labelText: 'Author'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the author';
                }
                return null;
              },
            ),
            TextFormField(
              controller: publisherController,
              decoration: InputDecoration(labelText: 'Publisher'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the publisher';
                }
                return null;
              },
            ),
            TextFormField(
              controller: synopsisController,
              decoration: InputDecoration(labelText: 'Synopsis'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a synopsis';
                }
                return null;
              },
            ),
            TextFormField(
              controller: coverImagePathController,
              decoration: InputDecoration(labelText: 'Cover Image Path'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the cover image path';
                }
                return null;
              },
            ),
             TextFormField(
              controller: stockController,
              decoration: InputDecoration(labelText: 'Stock'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the stock';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSave,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
