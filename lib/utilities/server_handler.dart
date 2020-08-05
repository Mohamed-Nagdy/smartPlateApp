import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_plate/constants.dart';
import 'package:smart_plate/models/image_content_model.dart';
import 'package:smart_plate/models/images_model.dart';
import 'package:smart_plate/models/meal_model.dart';
import 'package:smart_plate/models/post_model.dart';
import 'package:smart_plate/screens/main_app_screen.dart';
import 'package:smart_plate/utilities/network.dart';
import 'package:smart_plate/utilities/shared_data.dart';

class ServerHandler{

  BuildContext context;

  ServerHandler({this.context});

  void getPosts() async
  {
    NetworkHelper helper = NetworkHelper();

    var response = await helper.getData(SERVER_LINK + '?posts');
    var provider = Provider.of<SharedData>(context, listen: false);
//    while(response != null)
//      {
//        var response = await helper.getData(SERVER_LINK + '?posts');
//        print(response);
//      }
    for(int i = 0; i < response.length; i ++)
      {
        Post post = Post();
        post.postId = response[i]['post_id'];
        post.postTitle = response[i]['post_title'];
        post.postContent = response[i]['post_content'];
        post.userName = response[i]['user_name'];
        post.userImage = response[i]['user_image'];
        post.postImage = response[i]['post_image'];
        post.postDate = response[i]['post_date'];
        post.postPrivacy = response[i]['post_privacy'];
        post.userId = response[i]['user_id'];

        provider.addToAllPosts(post);

        if(post.userId == provider.users[0].userId)
          {
            provider.addToUserPosts(post);
          }

      }

    getMeals();

  }

  void getMeals() async
  {
    int imagesCounter = 0;
    int recipeCounter = 0;

    NetworkHelper helper = NetworkHelper();
    var provider = Provider.of<SharedData>(context, listen: false);
    var response = await helper.getData(SERVER_LINK + '?meals&user_id=${provider.users[0].userId}');

    for (int i = 0; i < response['meal_data'].length; i ++)
      {
        Meal meal = Meal();
        meal.mealId = response['meal_data'][i]['meal_id'];
        meal.quarter1Weight = response['meal_data'][i]['quarter_1_weight'];
        meal.quarter2Weight = response['meal_data'][i]['quarter_2_weight'];
        meal.quarter3Weight = response['meal_data'][i]['quarter_3_weight'];
        meal.quarter4Weight = response['meal_data'][i]['quarter_4_weight'];
        meal.energy = response['meal_data'][i]['Energy'];
        meal.fat = response['meal_data'][i]['Fat'];
        meal.protein = response['meal_data'][i]['Protein'];
        meal.carbs = response['meal_data'][i]['Carbs'];
        meal.date = response['meal_data'][i]['date'];
        
        provider.addToEnergyPoints(DataPoint<double>(value: double.parse(response['meal_data'][i]['Energy'].toString()), xAxis: double.parse((i+1).toString())));
        provider.addToCarbsPoints(DataPoint<double>(value: double.parse(response['meal_data'][i]['Carbs'].toString()), xAxis: double.parse((i+1).toString())));
        provider.addToFatPoints(DataPoint<double>(value: double.parse(response['meal_data'][i]['Fat'].toString()), xAxis: double.parse((i+1).toString())));
        provider.addToProteinPoints(DataPoint<double>(value: double.parse(response['meal_data'][i]['Protein'].toString()), xAxis: double.parse((i+1).toString())));

        for(int j = 0 ; j < 4; j++)
          {
            MealImage mealImage = MealImage();
            mealImage.imageId = response['images'][imagesCounter]['image_id'];
            mealImage.image = response['images'][imagesCounter]['image'];
            meal.images.add(mealImage);

            imagesCounter ++;
          }

        for(int j = 0 ; j < 4; j++)
        {
          Recipe recipe = Recipe();
          recipe.recipeId = response['recipe'][recipeCounter]['recipe_id'];
          recipe.recipe = response['recipe'][recipeCounter]['recipe'].toString().replaceAll('%20', ' ');
          meal.recipes.add(recipe);

          recipeCounter ++;
        }

        provider.addToMeals(meal);

      }

    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){
      return MainAppScreen();
    }));

  }

}