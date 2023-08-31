
import 'package:appfetch/app/data/models/quotes.dart';
import 'package:appfetch/app/providers/quotes/quotes_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart' hide ContextExtension;

import '../../../rutes/paths.dart';

class QuoteListItem extends StatelessWidget {
  final Quotes quote2;
  final int index;
 QuoteListItem({super.key, required this.quote2, this.index = 0});
  final delete = QuoteNotifier();

  @override
  Widget build(BuildContext context) {
    String quote = quote2.quote.orIf();
    String author = quote2.author.currency();

    return InkTouch(
      onTap: () {
        context.push(Paths.quoteDetails, extra: quote2);
      },
      border: Br.only(['t'], except: index == 0),
      padding: Ei.all(20),
      child: Row(
        children: [
          Col(
            children: [
              Text(quote, overflow: Tof.ellipsis),
              Text(author),
            ],
          ).flexible(),
          LzButton(
            icon: (Ti.trash),
            onTap: (state) {
              delete.deleteQuotes();
            },
          ),
        ],
      ),
    );
  }
}
