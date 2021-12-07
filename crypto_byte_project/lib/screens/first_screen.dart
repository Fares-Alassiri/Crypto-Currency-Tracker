import 'package:crypto_byte_project/models/fetchCoins_models/big_data_model.dart';
import 'package:crypto_byte_project/repository/repository.dart';
import 'package:crypto_byte_project/screens/second_screen.dart';
import 'package:crypto_byte_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../notification_service.dart';

NotificationService a = NotificationService();

class FirstScreen extends StatefulWidget {
  const FirstScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late Future<BigDataModel> _futureCoins;
  late Repository repository;
  @override
  void initState() {
    repository = Repository();
    _futureCoins = repository.getCoins();
    super.initState();

    a.init();
    listenNotification();
    a.scheduleNotifications();
  }

  void listenNotification() =>
      NotificationService.onNotifications.stream.listen((payload) {
        Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (context) => SecondScreen()));
      });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BigDataModel>(
      future: _futureCoins,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var coinsData = snapshot.data!.dataModel;
            return CoinListWidget(coins: coinsData);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
