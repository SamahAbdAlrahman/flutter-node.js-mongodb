class RecipeStepsModel {
  final String step;
  final int number;

  RecipeStepsModel({required this.step, required this.number});

  factory RecipeStepsModel.fromJson(Map<String, dynamic> json) {
    return new RecipeStepsModel(
      step: json['step'],
      number: json['number'],
    );
  }
}
