import 'package:flutter/material.dart';

class SectionPage extends StatelessWidget {
  const SectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section Page'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('https://example.com/image1.jpg'),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Title 1',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Description 1',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('https://example.com/image2.jpg'),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Title 2',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Description 2',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
