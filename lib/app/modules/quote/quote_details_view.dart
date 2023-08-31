import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/models/quotes.dart';

class QuoteDetailsView extends StatelessWidget {
  final Quotes quote1;
  const QuoteDetailsView({super.key, required this.quote1});

  @override
  Widget build(BuildContext context) {
    String? quote = quote1.quote;
    String author = quote1.author.orIf();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote Details'),
      ),
      body: LzListView(
        children: [
          Text(quote ?? '', style: Gfont.fs18),
          Textr(author, style: Gfont.fs20.bold, margin: Ei.only(b: 15)),

        ],
      ),
    );
  }
}
