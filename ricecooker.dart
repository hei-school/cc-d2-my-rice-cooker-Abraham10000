import 'dart:io';

class RiceCooker {
  double _maxCapacity;
  double _currentCapacity = 0;
  bool _isWorking = true;

  RiceCooker(this._maxCapacity);

  void addItems(List<List<dynamic>> items) {
    double totalQuantity = 0;
    items.forEach((item) {
      var quantity = item[1] as double;
      var unit = item[2] as String;
      var convertedQuantity = _convertToLiters(quantity, unit);

      if (_currentCapacity + convertedQuantity > _maxCapacity) {
        throw ('Capacité maximale dépassée');
      }

      _currentCapacity += convertedQuantity;
      totalQuantity += convertedQuantity;
      print('Ajout de $quantity $unit de ${item[0]}');
    });

    print('Total ajouté : $totalQuantity litres');
  }

  void cook(double cookingTime) {
    if (!_isWorking) {
      throw ('Le rice cooker doit être réparé');
    }

    print('La cuisson démarre pour $cookingTime minutes...');
    _simulateCooking(cookingTime);

    print('La cuisson est terminée');
  }

  void checkStatus() {
    _isWorking = true; // Simulation : le rice cooker est toujours fonctionnel
  }

  double _convertToLiters(double quantity, String unit) {
    if (unit.toLowerCase() == 'l') {
      return quantity;
    } else if (unit.toLowerCase() == 'kg') {
      return quantity * 1.2;
    } else {
      throw ('Unité non prise en charge');
    }
  }

  void _simulateCooking(double cookingTime) {
    sleep(Duration(minutes: cookingTime.toInt()));
  }
}

void runRiceCooker() {
  var riceCooker = RiceCooker(10);

  var itemsToCook = _gatherItemsToCook();
  riceCooker.addItems(itemsToCook);

  var cookingTime = _getCookingTime();
  riceCooker.cook(cookingTime);

  if (true) {
    riceCooker.checkStatus(); // Ajoutez la méthode checkStatus si nécessaire
    print('La cuisson est terminée.');
  }
}

List<List<dynamic>> _gatherItemsToCook() {
  var itemsToCook = <List<dynamic>>[];
  stdout.write('Combien d\'aliments voulez-vous cuire ? ');
  var numItems = int.parse(stdin.readLineSync()!);

  for (var i = 0; i < numItems; i++) {
    stdout.write('Aliment ${i + 1} : ');
    var item = stdin.readLineSync()!;

    stdout.write('Quantité de $item : ');
    var quantity = double.parse(stdin.readLineSync()!);

    stdout.write('Unité de $item (L pour litres / kg pour kilogrammes) : ');
    var unit = stdin.readLineSync()!;

    itemsToCook.add([item, quantity, unit]);
  }

  return itemsToCook;
}

double _getCookingTime() {
  stdout.write('Combien de temps de cuisson en minutes ? ');
  return double.parse(stdin.readLineSync()!);
}

void main() {
  runRiceCooker();
}
