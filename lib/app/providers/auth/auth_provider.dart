import 'package:appfetch/app/data/local/shared_preferences.dart';
import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/api/api.dart';
import '../../rutes/paths.dart';

final authProvider = ChangeNotifierProvider((ref) => Auth());

class Auth with ChangeNotifier, UseApi {
  final forms = LzForm.make(['username', 'password']);

  Future login(BuildContext context) async {
    try {
      final form = LzForm.validate(forms);

      LzToast.overlay('Logging in...');
      ResHandler res = await authApi.login(form.value);

      if (!res.status) {
        return LzToast.show(res.message);
      }

      String? token = res.body['token'];

      if (token != null) {
        if (!context.mounted) return;

        prefs.setString('token', token);
        context.go(Paths.quote);
      }

      return LzToast.show('Nice! You are logged in');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }

  Future logout(BuildContext context) async {
    try {
      LzToast.overlay('Logging out...');
      await Future.delayed(2.s);

      prefs.remove('token');

      // go to login page
      if (!context.mounted) return;
      context.go(Paths.login);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}
