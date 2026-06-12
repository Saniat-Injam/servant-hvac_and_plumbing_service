import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app.dart';
import 'core/services/auth_service.dart';
import 'core/services/stripe_keys.dart';
import 'core/utils/logging/loggerformain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  await dotenv.load(fileName: '.env');
  _setup();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
        (value) {
      Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
      runApp(const MyApp());
    },
  );
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}
