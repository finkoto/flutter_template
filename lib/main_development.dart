import 'dart:async';

import 'package:flutter_template/src/app.dart';
import 'package:flutter_template/src/bootstrap.dart';

void main() async {
  unawaited(
    bootstrap(
      () async {
        // TODO(suatkeskin): register auth repository
        /*
        final authenticationRepository = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
        );
        */

        // TODO(suatkeskin): register api client
        /*
        final apiClient = ApiClient(
          baseUrl: 'https://top-dash-dev-api-synvj3dcmq-uc.a.run.app',
          idTokenStream: authenticationRepository.idToken,
          refreshIdToken: authenticationRepository.refreshIdToken,
          appCheckTokenStream: appCheck.onTokenChange,
          appCheckToken: await appCheck.getToken(),
        );
        */

        // await authenticationRepository.signInAnonymously();
        // await authenticationRepository.idToken.first;

        return MyApp();
      },
    ),
  );
}
