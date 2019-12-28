enum FoodType { Type1, Type2, Type3, Type4, Type5, Type6, Type7 }

class FoodMenu {
  final FoodType foodType;
  final String title;
  FoodMenu({this.foodType, this.title});
}

class FoodMenuInfo {
  final FoodMenu foodMenu;
  final String numPosts;
  FoodMenuInfo({this.foodMenu, this.numPosts});
}

final foodMenu = [
  FoodMenu(
      foodType: FoodType.Type1,
      title: "အသား/ငါးဟင်း"),
  FoodMenu(
      foodType: FoodType.Type2,
      title: "အသုတ် ပြုလုပ်နည်း"),
  FoodMenu(
      foodType: FoodType.Type3,
      title: "မုန့်လုပ်နည်း"),
  FoodMenu(
      foodType: FoodType.Type4,
      title: "အသား/ငါး ပေါင်းနည်း"),
  FoodMenu(
      foodType: FoodType.Type1,
      title: "ဟင်းရည်ပြုလုပ်နည်း"),
  FoodMenu(
      foodType: FoodType.Type5,
      title: "အသီးအရွက်ချက်နည်း"),
  FoodMenu(
      foodType: FoodType.Type6,
      title: "အခြား ပြုလုပ်နည်း")
];

final foodInfo = foodMenu.map((f)=> FoodMenuInfo(foodMenu: f, numPosts: "10000 Post")).toList();
