import 'package:crypto_byte_project/widgets/coin_fav_widget.dart';

class FavList {
  static var Fav = List<int>.filled(20, 0, growable: true);
  static var counter = 0;
  static addToFav(int id, bool x) {
    if (x) {
      if (id == 1) id = 0;
      if (id == 1027) id = 1;
      if (id == 1839) id = 2;
      if (id == 825) id = 3;
      if (id == 5426) id = 4;
      if (id == 2010) id = 5;
      if (id == 3408) id = 6;
      if (id == 52) id = 7;
      if (id == 6636) id = 8;
      if (id == 4172) id = 9;
      if (id == 74) id = 10;
      if (id == 5805) id = 11;
      if (id == 5994) id = 12;
      if (id == 3890) id = 13;
      if (id == 3635) id = 14;
      if (id == 4687) id = 15;
      if (id == 3717) id = 16;
      if (id == 2) id = 17;
      if (id == 7083) id = 18;
      if (id == 4030) id = 19;

      Fav[counter] = id;
      print(Fav);
      counter++;
    }
    //print(Fav);
    return Fav;
  }

  static removeFromFav(int id) {
    if (id == 1) id = 0;
    if (id == 1027) id = 1;
    if (id == 1839) id = 2;
    if (id == 825) id = 3;
    if (id == 5426) id = 4;
    if (id == 2010) id = 5;
    if (id == 3408) id = 6;
    if (id == 52) id = 7;
    if (id == 6636) id = 8;
    if (id == 4172) id = 9;
    if (id == 74) id = 10;
    if (id == 5805) id = 11;
    if (id == 5994) id = 12;
    if (id == 3890) id = 13;
    if (id == 3635) id = 14;
    if (id == 4687) id = 15;
    if (id == 3717) id = 16;
    if (id == 2) id = 17;
    if (id == 7083) id = 18;
    if (id == 4030) id = 19;

    Fav.remove(id);

    counter--;
    print(Fav);
    print(counter);
  }

  static getCounter() {
    return counter;
  }

  static getFav() {
    return Fav;
  }
}
