
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart';

import '../data/local/shared_preferences.dart';
import '../data/models/quotes.dart';
import '../modules/login/login_view.dart';
import '../modules/quote/quote_details_view.dart';
import '../modules/quote/quote_view.dart';
import 'paths.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: Paths.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginView(), redirect: (context, _) async => _getRouteName(context)),
            
    GoRoute(
        path: Paths.quote,
        builder: (BuildContext context, GoRouterState state) =>
            const QuoteView()),

    GoRoute(
        path: Paths.quoteDetails,
        builder: (BuildContext context, GoRouterState state) =>
            QuoteDetailsView(quote1: state.extra as Quotes)),
  ],
);

String _getRouteName(BuildContext context) {
  String? token = prefs.getString('token');
  return token.hasNullOrEmpty ? Paths.login : Paths.quote;
}