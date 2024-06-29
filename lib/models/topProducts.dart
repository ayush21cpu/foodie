class TopProducts{

  String imagePath;
  String title;
  String subTitle;
  String prize;

  TopProducts({required this.imagePath,required this.title,required this.subTitle,required this.prize});
}
List<TopProducts> topProdus=[
  TopProducts(imagePath: "images/salad2.png", title: "Veggie Taco Hash", subTitle: "Fresh and Healthy", prize: "\$25"),
  TopProducts(imagePath: "images/salad3.png", title: "Mix Veg Salad", subTitle: "Spicy with Onion", prize: "\$28"),
  TopProducts(imagePath: "images/salad2.png", title: "Veggie Taco Hash", subTitle: "Fresh and Healthy", prize: "\$25"),
  TopProducts(imagePath: "images/salad3.png", title: "Mix Veg Salad", subTitle: "Spicy with Onion", prize: "\$28"),
  TopProducts(imagePath: "images/salad2.png", title: "Veggie Taco Hash", subTitle: "Fresh and Healthy", prize: "\$25"),
  TopProducts(imagePath: "images/salad3.png", title: "Mix Veg Salad", subTitle: "Mediterranean Chickpea Salad", prize: "\$28"),


];
