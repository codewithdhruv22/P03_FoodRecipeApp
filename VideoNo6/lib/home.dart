import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/model.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipeList =  <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();

  getRecipes(String query) async
  {
    String url = "https://api.edamam.com/search?q=$query&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);


    data["hits"].forEach((element){
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      log(recipeList.toString());
    });

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xff213A50),
                    Color(0xff071938)
                  ]
              ),
            ),
          ),

      SingleChildScrollView(
        child: Column(
                children: [


                  //Search Bar
                  SafeArea(
                    child: Container(
                      //Search Wala Container

                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if((searchController.text).replaceAll(" ", "") == "")
                              {
                                print("Blank search");
                              }else{
                                getRecipes(searchController.text);
                              }

                            },
                            child: Container(
                              child: Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Let's Cook Something!"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("WHAT DO YOU WANT TO COOK TODAY?", style: TextStyle(fontSize: 33, color: Colors.white),),
                        SizedBox(height: 10,),
                        Text("Let's Cook Something New!", style: TextStyle(fontSize: 20,color: Colors.white),)
                      ],
                    ),
                  ),
                  Container(
                    child:
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 100,
                                    itemBuilder: (context, index){
                                  return MyText();
                                })
                  )
                ],
              ),
      )

        ],
      ),
    );
  }
}

Widget MyText()
{
  return Text("MY TEXT WIDGET IS HERE");
}