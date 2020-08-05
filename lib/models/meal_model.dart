import 'package:smart_plate/models/image_content_model.dart';
import 'package:smart_plate/models/images_model.dart';

class Meal{
  var mealId;
  var quarter1Weight;
  var quarter2Weight;
  var quarter3Weight;
  var quarter4Weight;
  var energy;
  var protein;
  var fat;
  var carbs;
  var date;
  List<MealImage> images = [];
  List<Recipe> recipes = [];
}