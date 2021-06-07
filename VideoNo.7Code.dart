import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_food_recipe_app/models/recipeSearchModel.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipes = new List<RecipeModel>();
  TextEditingController searchController = new TextEditingController();
  getRecipes(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=14d768d2&app_key=6d037e21b672ce0508618ecc94f9bb1f";
    var response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipes.add(recipeModel);
    });
    print(recipes);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes("Mango Juice");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color(0xff213A50),
              const Color(0xff071938)
            ])),
          ),
          SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
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
                          getRecipes(searchController.text);
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.indigo[900],
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          controller: searchController,
                            onSubmitted: (value) {getRecipes(searchController.text);},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Samosa"),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What You Will Cook Today ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Make Something New Make Something Cool.",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.6)),
                          elevation: 0.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  recipes[index].imgUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration:
                                        BoxDecoration(color: Colors.black54),
                                    child: Text(
                                      recipes[index].label,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )),
                              Positioned(
                                right: 0,
                                  child:Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)

                                  )
                                ),

                                height: 50,
                                width: 100,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.local_fire_department),
                                      Text(recipes[index].calories.toString().substring(0,6), style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ]),

    );
  }
}
