// import 'package:flutter/material.dart';

// class CategorySection extends StatefulWidget {
//   final String category;
//   final List<dynamic> items; // or your specific item type
//   final List<dynamic> providers; // or your provider type

//   const CategorySection({
//     super.key,
//     required this.category,
//     required this.items,
//     required this.providers,
//   });

//   @override
//   State<CategorySection> createState() => _CategorySectionState();
// }

// class _CategorySectionState extends State<CategorySection> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.category)), // using the variable
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Category: ${widget.category}',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),

//             // List of Items
//             const Text(
//               'Items:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),
//             ...widget.items.map(
//               (item) => Text(item, style: const TextStyle(fontSize: 16)),
//             ),

//             const SizedBox(height: 16),

//             // List of Providers
//             const Text(
//               'Providers:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),
//             ...widget.providers.map(
//               (provider) =>
//                   Text(provider, style: const TextStyle(fontSize: 16)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final String category;
  final List<dynamic> items;
  final List<dynamic> providers;

  const CategorySection({
    super.key,
    required this.category,
    required this.items,
    required this.providers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),

        // Items List
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Items:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        ...items.map((item) {
          final name = item['descriptor']?['name'] ?? 'Unknown Item';
          final imageUrl =
              (item['descriptor']?['images'] != null &&
                  item['descriptor']['images'].isNotEmpty)
              ? item['descriptor']['images'][0]
              : null;
          final qty = item['quantity']?['available']?['count'] ?? '-';
          final unit = item['quantity']?['unitized']?['measure']?['unit'] ?? '';
          final batches = (item['batches'] as List<dynamic>? ?? []);

          return Card(
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: imageUrl != null
                  ? Image.network(imageUrl, width: 50, height: 50)
                  : const Icon(Icons.shopping_bag, size: 40),
              title: Text(name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Available: $qty $unit"),
                  if (batches.isNotEmpty)
                    Text(
                      "Price: ₹${batches[0]['price']?['value'] ?? '-'} / ${unit.isNotEmpty ? unit : ''}",
                    ),
                ],
              ),
            ),
          );
        }),

        const SizedBox(height: 16),

        // Providers List
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Providers:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        ...providers.map((provider) {
          final name = provider['descriptor']?['name'] ?? 'Unknown Provider';
          final location =
              (provider['locations'] != null &&
                  provider['locations'].isNotEmpty)
              ? provider['locations'][0]['address']
              : 'No Address';
          return Card(
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.store, color: Colors.green, size: 40),
              title: Text(name),
              subtitle: Text(location),
            ),
          );
        }),
      ],
    );
  }
}
