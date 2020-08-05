import 'package:flutter/material.dart';
import 'package:smart_plate/constants.dart';
import 'package:smart_plate/widgets/single_image_container.dart';

class MealContainer extends StatelessWidget {

  final title,energy, protein, fat, carbs, date, images, recipes, quarter1Weight, quarter2Weight, quarter3Weight, quarter4Weight;

  MealContainer({this.title,this.energy, this.protein, this.fat, this.carbs, this.date, this.images, this.recipes, this.quarter1Weight, this.quarter2Weight, this.quarter3Weight, this.quarter4Weight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: Material(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Energy : $energy',
                          style: USER_INFO_STYLE,
                        ),
                        Text(
                          'Protein : $protein',
                          style: USER_INFO_STYLE,
                        ),
                        Text(
                          'Fat : $fat',
                          style: USER_INFO_STYLE,
                        ),
                        Text(
                          'Carbs : $carbs',
                          style: USER_INFO_STYLE,
                        ),
                        Text(
                          'Date : $date',
                          style: USER_INFO_STYLE,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SingleImageContainer(
                    image: IMAGES_LINK + images[0].image,
                    description: recipes[0].recipe,
                    weight: quarter1Weight,
                  ),
                  SingleImageContainer(
                    image: IMAGES_LINK + images[1].image,
                    description: recipes[1].recipe,
                    weight: quarter2Weight,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SingleImageContainer(
                    image: IMAGES_LINK + images[2].image,
                    description: recipes[2].recipe,
                    weight: quarter3Weight,
                  ),
                  SingleImageContainer(
                    image: IMAGES_LINK + images[3].image,
                    description: recipes[3].recipe,
                    weight: quarter4Weight,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
