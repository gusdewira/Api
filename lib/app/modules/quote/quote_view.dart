import 'package:appfetch/app/providers/auth/auth_provider.dart';
import 'package:appfetch/app/providers/quotes/quotes_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'widgets/quote_list_item.dart';


class QuoteView extends ConsumerWidget {
  const QuoteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(quoteProvider.notifier);
    final key = GlobalKey();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Quotes'),
          actions: [
            Icon(Ti.settings, key: key).onPressed(() {
              DropX.show(key,
                  options: [
                    'Refresh',
                    'Logout'
                  ].options(icons: [Ti.reload, Ti.logout], dangers: [1]), onSelect: (state) {
                if (state.option == 'Logout') {
                  LzConfirm(
                      title: 'Logout',
                      message: 'Are you sure want to logout?',
                      onConfirm: () {
                        final authNotifier = ref.read(authProvider.notifier);
                        authNotifier.logout(context);
                      }).show(context);
                } else {
                  notifier.getQuotes();
                }
              });
            })
          ],
        ),
        body: Consumer(builder: (context, ref, _) {
          final asyncData = ref.watch(quoteProvider);

          return asyncData.when(
            data: (todos) {
              if (todos.isEmpty) {
                return LzNoData(
                    message: 'Opps! No data found',
                    onTap: () => notifier.getQuotes());
              }

              return Refreshtor(
                onRefresh: () async => notifier.getQuotes(),
                child: LzListView(
                  padding: Ei.zero,
                  children: todos.generate(
                      (item, i) => QuoteListItem(quote2: item, index: i)),
                ),
              );
            },
            loading: () => LzLoader.bar(message: 'Loading...'),
            error: (error, _) => LzNoData(message: 'Opps! $error'),
          );
        }));
  }
}
