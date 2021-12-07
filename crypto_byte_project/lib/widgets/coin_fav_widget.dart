import 'package:crypto_byte_project/models/chart_data_model.dart';
import 'package:crypto_byte_project/models/fetchCoins_models/fetch_coins_models.dart';
import 'package:crypto_byte_project/screens/coin_detail_screen.dart';
import 'package:crypto_byte_project/widgets/coin_logo_widget.dart';
import 'package:crypto_byte_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_byte_project/widgets/fav_list.dart';
import 'package:crypto_byte_project/widgets/fav_detail_screen.dart';

class CoinFavWidget extends StatelessWidget {
  final List<DataModel> coins;

   CoinFavWidget({

    required this.coins,
  });
  var Fav = new List.generate(20, (_) => []);
  var counter = 0;
  addToFav(int id){
    Fav[counter].add(id);
    print(Fav);
    counter++;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              "Crypto Markets",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Divider(
            height: 7,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.builder(
              itemExtent: 160,
              itemCount: FavList.getCounter(),
              itemBuilder: (context, index) {
                List<DataModel> favcoins = [coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],coins[0],];
                List y = FavList.getFav();
                int i=0;
                y.forEach((e){
                  favcoins[i] = coins[e];
                  i++;
                });
                var coin = favcoins[index];
                var coinPrice = coin.quoteModel.usdModel;
                var data = [
                  ChartData(coinPrice.percentChange_90d, 2160),
                  ChartData(coinPrice.percentChange_60d, 1440),
                  ChartData(coinPrice.percentChange_30d, 720),
                  ChartData(coinPrice.percentChange_24h, 24),
                  ChartData(coinPrice.percentChange_1h, 1),
                ];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavDetailScreen(coin: coin)),
                    );
                  },
                  child: Container(
                    height: 160.0,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 11.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CoinLogoWidget(coin: coin),
                        CoinChartWidget(
                          data: data,
                          coinPrice: coinPrice,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
