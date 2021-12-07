import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_byte_project/models/fetchCoins_models/fetch_coins_models.dart';
import 'package:crypto_byte_project/widgets/fav_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crypto_byte_project/models/models.dart';
import 'package:crypto_byte_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_byte_project/models/fetchCoins_models/fetch_coins_models.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FavDetailScreen extends StatelessWidget {
  final DataModel coin;
  const FavDetailScreen({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int next(int min, int max) => random.nextInt(max - min);
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
    var coinPrice = coin.quoteModel.usdModel;
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(coinPrice.lastUpdated);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var data = [
      ChartData(next(110, 140), 1),
      ChartData(next(9, 41), 3),
      ChartData(next(140, 200), 3),
      ChartData(coinPrice.percentChange_24h, 4),
      ChartData(coinPrice.percentChange_1h, 5),
      ChartData(next(110, 140), 6),
      ChartData(next(9, 41), 7),
      ChartData(next(140, 200), 8),
      ChartData(coinPrice.percentChange_24h, 9),
      ChartData(coinPrice.percentChange_1h, 10),
      ChartData(next(110, 140), 12),
      ChartData(next(9, 41), 13),
      ChartData(coinPrice.percentChange_1h, 14),
      ChartData(next(9, 41), 15),
      ChartData(next(140, 200), 16),
      ChartData(coinPrice.percentChange_24h, 17),
      ChartData(coinPrice.percentChange_1h, 18),
      ChartData(next(110, 140), 19),
      ChartData(next(9, 41), 20),
      ChartData(next(140, 200), 21),
      ChartData(coinPrice.percentChange_24h, 22),
      ChartData(next(110, 140), 23),
    ];
    _launchURL() async {
      String url = 'https://www.binance.com/en/trade/' + coin.symbol + '_usdt';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    removeFromFav() {
      FavList.removeFromFav(coin.id);
    }

    print(coin.id);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        child: CustomScrollView(
          slivers: [
            CoinDetailAppBar(coin: coin, coinIconUrl: coinIconUrl),
            CoinRandomedChartWidget(
                coinPrice: coinPrice, outputDate: outputDate, data: data),
            SliverToBoxAdapter(
              child: Container(
                height: 500,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      height: 300.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Circulating Supply:       ",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                coin.circulatingSupply.toStringAsFixed(2),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Max Supply:                     ",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                coin.maxSupply.toStringAsFixed(2),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Market pairs:                   ",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                coin.numMarketPairs.toString(),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Market Cap:                     ",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                coin.quoteModel.usdModel.marketCap
                                    .toStringAsFixed(2),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                  onPressed: _launchURL,
                                  color: Colors.black12,
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                          "assets/images/Binance-Coin-icon.png"),
                                      Text(" Buy from Binance ")
                                    ],
                                  ),
                                ),
                                FlatButton(
                                  onPressed: removeFromFav,
                                  color: Colors.black12,
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset("assets/images/heart.png"),
                                      Text(" Remove from favorites ")
                                    ],
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
