import 'package:appfetch/app/data/api/api.dart';
import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/quotes.dart';

class QuoteNotifier extends StateNotifier<AsyncValue<List<Quotes>>>
    with UseApi {
  final AutoDisposeStateNotifierProviderRef?
      ref; 

  QuoteNotifier({this.ref}) : super(const AsyncValue.loading()) {
    // get data produk saat pertama kali halaman produk dimuat
    getQuotes();
  }

  Future getQuotes() async {
    try {
      // set loading state
      state = const AsyncValue.loading();

      // call api
      ResHandler res = await quoteApi.getQuotes();

      // prepare data
      List data = res.body?['quotes'] ?? [];

      // set data
      state = AsyncValue.data(data.map((e) => Quotes.fromJson(e)).toList());
    } catch (e, s) {
      Errors.check(e, s, useList: true);
    }
  }

  Future deleteQuotes() async {
try {
  final prefs = await SharedPreferences.getInstance();

  prefs.remove('quotes');
} catch (e, s) {
  Errors.check(e, s, useList: true);
  
}
  }
}

final quoteProvider = StateNotifierProvider.autoDispose<QuoteNotifier,
    AsyncValue<List<Quotes>>>((ref) {
  return QuoteNotifier(ref: ref);
});
