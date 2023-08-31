part of api;

class QuoteApi extends Fetchly {
  Future<ResHandler> getQuotes() async => await get('quotes');
}
