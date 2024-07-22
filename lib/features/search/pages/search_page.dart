import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.sizeOf(context).width * .85,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Search YouTube',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue))),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
