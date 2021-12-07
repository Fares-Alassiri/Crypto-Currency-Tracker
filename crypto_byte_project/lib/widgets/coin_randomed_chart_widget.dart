import 'package:crypto_byte_project/models/fetchCoins_models/fetch_coins_models.dart';
import 'package:crypto_byte_project/models/models.dart';
import 'package:crypto_byte_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CoinRandomedChartWidget extends StatefulWidget {
  const CoinRandomedChartWidget({
    Key? key,
    required this.coinPrice,
    required this.outputDate,
    required this.data,
  }) : super(key: key);

  final UsdModel coinPrice;
  final String outputDate;
  final List<ChartData> data;

  @override
  _CoinRandomedChartWidgetState createState() =>
      _CoinRandomedChartWidgetState();
}

class _CoinRandomedChartWidgetState extends State<CoinRandomedChartWidget> {
  List<bool> _isSelected = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: SliverAppBarDelegate(
        minHeight: 360.0,
        maxHeight: 360.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            children: [
              Text(
                '\$' + widget.coinPrice.price.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                widget.outputDate,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              CoinChartWidget(
                  coinPrice: widget.coinPrice,
                  color: Colors.green,
                  data: widget.data),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
