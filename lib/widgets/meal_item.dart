import 'package:dyte/models/meal.dart';
import 'package:dyte/widgets/meal_item_trait.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase()+meal.affordability.name.substring(1);
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 200,
      child:InkWell(
          onTap: (){
            onSelectMeal(meal); 
          },
          splashColor: Colors.white,
          child: Stack(
            children: [
              FadeInImage(
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min',
                            
                          ),
                          SizedBox(width: 12),
                          MealItemTrait(
                            icon: Icons.work,
                            label: complexityText,
                          ),
                          SizedBox(width: 12,),
                          MealItemTrait(
                            icon: Icons.attach_money,
                            label: affordabilityText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
