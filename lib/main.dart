import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/Pokedex.dart';
import 'package:pokemon/Pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cubit/search_cubit.dart';

import 'package:pokemon/pokemonClass.dart' show Pokemon;
import 'package:http/http.dart' as http;

void main() async {
  List item=[];
  List<Pokemon> pokemons=[];
  WidgetsFlutterBinding.ensureInitialized();
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/pokemon.json');
    final data = await json.decode(response);
    item=data;
  }
  await readJson();
  for (int i=0;i<809;++i) {
    pokemons.add(Pokemon.fromJson(item[i]));
  }
  Pokedex pokedex = Pokedex(pokemons);
  runApp(myApp(pokedex: pokedex,));
}

class myApp extends StatelessWidget {
  final Pokedex pokedex;

  myApp({required this.pokedex});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      //home: M(pokedex: pokedex,),
      home: BlocProvider (
        create: (context) => searchCubit(pokedex),
        child: M(pokedex: pokedex,),
      ),
    );
  }
}

class M extends StatefulWidget {
  final String name = "hello";
  late final Pokedex pokedex;

  M({required this.pokedex});

  @override
  State<M> createState()=>_mState();
}

class _mState extends State<M> {
  final pokemonName = TextEditingController();
  String? _dropdownvalue="Lowest Number";
  late final List<Pokemon> Pokemons = widget.pokedex.pokedex;
  late List<Pokemon> pokemons = widget.pokedex.pokedex;
  void changeList() {
    setState(() {
      pokemons = Pokemons;
      pokemons.shuffle();
    });
  }
  int Compare(Pokemon a,Pokemon b,int type) {
    if (type==1) {
      if (a.id<b.id) return -1;
      else if (a.id>b.id) return 1;
      else return 0;
    }
    else {
      return a.name.compareTo(b.name);
    }
  }
  void onChanged(String? value) {
      pokemons = Pokemons;
      _dropdownvalue=value;
      if (_dropdownvalue=="Lowest Number") {
        pokemons.sort((a,b)=>Compare(a, b,1));
      }
      else if (_dropdownvalue=="Highest Number") {
        pokemons.sort((a,b)=>-Compare(a,b,1));
      }
      else if (_dropdownvalue=="From A-Z") {
        pokemons.sort((a,b)=>Compare(a,b,2));
      }
      else{
        pokemons.sort((a,b)=>-Compare(a, b, 2));
      }
      setState(() {

      });
  }
  List<String> req = <String>['Lowest Number', 'Highest Number', 'From A-Z', 'From Z-A'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: BlocListener<searchCubit,state>(
        listener: (context,state){
          if (state is searchInit){
            print("hello world");
          }
          else if (state is searchState){
            pokemons = state.result.pokedex;
            setState(() {

            });
            print("unga bunga");
          }
        },
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: pokemonName,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (){
                      final _cubit = BlocProvider.of<searchCubit>(context);
                      _cubit.searchPokemon(pokemonName.text);
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: changeList, child: Text('Suprise me',style: TextStyle(color: Colors.white,),),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text('Sort by',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    DropdownButton(
                      onChanged: onChanged,
                      value: _dropdownvalue,
                      items: req.map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                )

              ],
            ),
            Expanded(child: GridView.count(crossAxisCount: 4,children: pokemons.map((e) => pokemonTag(poketmonster: e)).toList(),
              childAspectRatio: 0.8,
            ),)
          ],
        )
      ),
    );
  }
  }