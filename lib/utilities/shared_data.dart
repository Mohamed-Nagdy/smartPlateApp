import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_plate/models/meal_model.dart';
import 'package:smart_plate/models/post_model.dart';
import 'package:smart_plate/models/user_model.dart';

class SharedData extends ChangeNotifier{

  var locale = Locale('en', '');
  List users = [];
  List<Post> allPosts = [];
  List<Post> userPosts = [];
  List<Meal> meals = [];
  List<DataPoint<double>> energyPoints = [];
  List<DataPoint<double>> carbsPoints = [];
  List<DataPoint<double>> fatPoints = [];
  List<DataPoint<double>> proteinPoints = [];

  void setLocale(Locale newLocale)
  {
    locale = newLocale;
    notifyListeners();
  }

  void addToUser(User user)
  {
    users.add(user);
    notifyListeners();
  }

  // user posts operations
  void addToUserPosts(Post post)
  {
    userPosts.insert(0, post);
    notifyListeners();
  }

  void removeFromUserPosts(Post post)
  {
    userPosts.remove(post);
    notifyListeners();
  }

  // all post operations
  void addToAllPosts(Post post)
  {
    allPosts.insert(0, post);
    notifyListeners();
  }

  void removeFromAllPosts(Post post)
  {
    allPosts.remove(post);
    notifyListeners();
  }

  // meals operations
  void addToMeals(Meal meal)
  {
    meals.add(meal);
    notifyListeners();
  }

  // add to energy points list
  void addToEnergyPoints(DataPoint<double> point)
  {
    energyPoints.add(point);
    notifyListeners();
  }

  // add to fat points list
  void addToFatPoints(DataPoint<double> point)
  {
    fatPoints.add(point);
    notifyListeners();
  }

  // add to carbs points list
  void addToCarbsPoints(DataPoint<double> point)
  {
    carbsPoints.add(point);
    notifyListeners();
  }

  // add to protein points list
  void addToProteinPoints(DataPoint<double> point)
  {
    proteinPoints.add(point);
    notifyListeners();
  }

}