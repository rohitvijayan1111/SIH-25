// // TODO Implement this library.
// import 'package:flutter/material.dart';

// class CategorySection extends StatefulWidget {
//   const CategorySection({super.key});

//   @override
//   State<CategorySection> createState() => _CategorySectionState();
// }

// class _CategorySectionState extends State<CategorySection> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Voice Page')),
//       body: const Center(
//         child: Text('This is the Voice Page', style: TextStyle(fontSize: 18)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  final String category;
  final List<dynamic> items; // or your specific item type
  final List<dynamic> providers; // or your provider type

  const CategorySection({
    super.key,
    required this.category,
    required this.items,
    required this.providers,
  });

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)), // using the variable
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: ${widget.category}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // List of Items
            const Text(
              'Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...widget.items.map(
              (item) => Text(item, style: const TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 16),

            // List of Providers
            const Text(
              'Providers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...widget.providers.map(
              (provider) =>
                  Text(provider, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
