import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_plate/utilities/shared_data.dart';
import 'package:smart_plate/widgets/meal_container.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<SharedData>(context);

    return SafeArea(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          actionsForegroundColor: Colors.white,
          backgroundColor: CupertinoColors.activeGreen,
          middle: Text('History', style: TextStyle(fontSize: 18, color: CupertinoColors.white),),
        ),
        child: ListView.builder(itemBuilder: (context, index){
          return MealContainer(
            title: 'Meal ${index + 1}',
            energy: provider.meals[index].energy,
            protein: provider.meals[index].protein,
            fat: provider.meals[index].fat,
            carbs: provider.meals[index].carbs,
            date: provider.meals[index].date,
            images: provider.meals[index].images,
            recipes: provider.meals[index].recipes,
            quarter1Weight: provider.meals[index].quarter1Weight,
            quarter2Weight: provider.meals[index].quarter2Weight,
            quarter3Weight: provider.meals[index].quarter3Weight,
            quarter4Weight: provider.meals[index].quarter4Weight,
          );
        },
        itemCount: provider.meals.length,
        ),
      ),
    );
  }

  @override
  void initState() {

    super.initState();
  }

}
