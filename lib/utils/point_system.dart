num caluclateCoins(int steps, int level) {
  var maxCoinEarnings = maxCoin(level);
  var coins = steps / 1000;
  if (coins > maxCoinEarnings) {
    return maxCoinEarnings;
  } else {
    return coins.toInt();
  }
}

int maxCoin(int level) {
  var maxCoin = 5;
  switch (level) {
    case 1:
      maxCoin = 5;
      break;
    case 2:
      maxCoin = 8;
      break;
    case 3:
      maxCoin = 12;
      break;
    default:
      return maxCoin;
  }
  return maxCoin;
}

String calculateCalories(int steps) {
  var calories = steps * 0.05;
  return calories.toStringAsPrecision(3);
}

String calculateDistance(int steps) {
  var kilometers = steps * (1 / 1400);
  return kilometers.toStringAsPrecision(3);
}

String levelMessage(int level) {
  String message = "Reach 5 coins, 3 Days in a row, to upgrade to LEVEL 2";
  switch (level) {
    case 1:
      message = "Reach 5 coins, 3 Days in a row, to upgrade to LEVEL 2";
      break;
    case 2:
      message = "Reach 8 coins, 5 Days in a row, to upgrade to LEVEL 3";
      break;
    case 3:
      message = "You can earn maximum of 12 coins";
      break;
    default:
      message = "You can earn maximum of 12 coins";
  }
  return message;
}
