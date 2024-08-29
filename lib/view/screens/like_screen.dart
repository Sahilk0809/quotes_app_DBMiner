import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/quotes_controller.dart';
import '../../modal/quote_modal.dart';
import 'home_screen.dart';

class LikedQuotesScreen extends StatelessWidget {
  const LikedQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueAccent.withOpacity(0.7),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Hero(
                  tag: 'likedQuotes',
                  child: Text(
                    'Favourite Quotes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'See your favourite quotes by category',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Obx(() {
                    if (controller.favouriteQuotes.isEmpty) {
                      return const Center(
                        child: Text(
                          'No favourite quotes added yet.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    }

                    // Group quotes by category
                    Map<String, List<QuotesModel>> groupedQuotes = {};
                    for (var quote in controller.favouriteQuotes) {
                      if (groupedQuotes.containsKey(quote.category)) {
                        groupedQuotes[quote.category]!.add(quote);
                      } else {
                        groupedQuotes[quote.category] = [quote];
                      }
                    }

                    return ListView.builder(
                      itemCount: groupedQuotes.keys.length,
                      itemBuilder: (context, index) {
                        String category = groupedQuotes.keys.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Card(
                            elevation: 8,
                            shadowColor: Colors.black38,
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ExpansionTile(
                                backgroundColor: Colors.white.withOpacity(0.1),
                                collapsedBackgroundColor:
                                Colors.blueAccent.withOpacity(0.7),
                                title: Text(
                                  category,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                                children: groupedQuotes[category]!.map((quote) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        quote.quote,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.black38,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      subtitle: Text(
                                        '- ${quote.author}',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          controller
                                              .deleteFavouriteQuote(quote.id!);
                                        },
                                        icon: const Icon(Icons.delete,
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
