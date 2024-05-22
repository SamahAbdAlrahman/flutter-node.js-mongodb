class Recipe {

  String title;
  String description;
  String image;
  int calories;
  int carbo;
  int protein;

  Recipe(this.title, this.description, this.image, this.calories, this.carbo, this.protein);

}

List<Recipe> getlaunchRecipes(){
  return <Recipe>[
    Recipe("Chicken Fried Rice", "So irresistibly delicious", "assets/images/chicken_fried_rice.png", 250, 35, 6),
    Recipe("Pasta Bolognese", "True Italian classic with a meaty, chilli sauce", "assets/images/pasta_bolognese.png", 200, 45, 10),
    Recipe("Garlic Potatoes", "Crispy Garlic Roasted Potatoes", "assets/images/filete_con_papas_cambray.png", 150, 30, 8),
    Recipe("Asparagus", "White Onion, Fennel, and watercress Salad", "assets/images/asparagus.png", 190, 35, 12),
    Recipe("Filet Mignon", "Bacon-Wrapped Filet Mignon", "assets/images/steak_bacon.png", 250, 55, 20),
  ];
}

List<Recipe> getBreakfastRecipes(){
  return <Recipe>[
    Recipe(" Falafel", "Falafel with tabouli and chickpea dip", "assets/img/falafel.jpeg", 250, 35, 6),
    Recipe("quinoa salad", "True Italian classic with a meaty", "assets/img/quinoa-salad.jpeg", 211, 45, 10),
    Recipe("Avocado toast", "delicious toast", "assets/img/toast.jpg", 392, 30, 8),
    Recipe("grilled eggplant", "Char-grilled eggplant and rocket salad", "assets/img/eggplant.jpeg", 190, 35, 12),
    Recipe("Healthy burger", "egg burger with vegetables", "assets/img/burger.jpg", 250, 55, 20),
  ];
}
List<Recipe> getDinnerRecipes(){
  return <Recipe>[
    Recipe("Vegetable soup", "So irresistibly delicious", "assets/img/soap.jpeg", 150, 35, 6),
    Recipe("Healthy tuna mornay", "True Italian classic with a meaty, chilli sauce", "assets/img/tuna.jpg", 272 , 45, 10),
    Recipe("baked sweet potatoes", "Mexican-style baked sweet potatoes", "assets/img/potatoes.jpg", 150, 30, 8),
    Recipe("Vegetable korma curry", "veggies with this tasty vegetable korma curry", "assets/img/vegetable.jpeg", 190, 35, 12),
    Recipe(" frittata", "Quick veg and cheese frittata", "assets/img/frittata.jpg", 250, 55, 20),
  ];
}
List<Recipe> snacks(){
  return <Recipe>[
    Recipe("mango balls", "Sugar-free mango and coconut balls", "assets/img/sugar.jpg", 190, 35, 12),
    Recipe("Broccoli nuggets", "These baked broccoli quinoa bites are delicious sprinkled .", "assets/img/broccoli.jpg", 150, 30, 8),
    Recipe("Milk Rice Pudding", "So irresistibly delicious", "assets/img/f29.jpg", 150, 35, 6),
    Recipe("Keto Mahalabiya", "So  delicious", "assets/img/f30.jpg", 180 , 45, 10),
    Recipe(" Healthy chocolate", "this snack will quickly become a healthy favourite", "assets/img/chocolate.jpeg", 180, 55, 20),
  ];
}