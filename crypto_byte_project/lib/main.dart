import 'package:crypto_byte_project/notification_service.dart';
import 'package:crypto_byte_project/screens/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:crypto_byte_project/widgets/widgets.dart';
import 'authentication_service.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp(MyApp());
  //listenNotification();
  await NotificationService().scheduleNotifications();
}

//void listenNotification() => NotificationService.onNotifications.stream.listen((payload) {Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => SecondScreen()))});

class MyApp extends StatelessWidget {
  CoinFavWidget Fav = new CoinFavWidget(
    coins: [],
  );

  @override
  Widget build(BuildContext context) {
    var textSize = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Sign In Sign Up Ui',
        theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.copyWith(
                  headline4: textSize.headline4!.copyWith(
                    color: Colors.white,
                  ),
                  headline5: textSize.headline5!.copyWith(color: Colors.white),
                  headline6: textSize.headline6!.copyWith(
                    color: Colors.white,
                  ),
                  subtitle1: textSize.subtitle1!.copyWith(
                    color: Colors.white,
                  ),
                  subtitle2: textSize.subtitle2!.copyWith(
                    color: Colors.grey,
                  ),
                  overline: textSize.overline!.copyWith(color: Colors.grey),
                ),
          ),
          scaffoldBackgroundColor: kBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: ThemeMode.dark,
        home: WelcomePage(),
      ),
    );
  }
}
