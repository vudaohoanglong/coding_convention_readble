import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/model/Pokedex.dart';
import 'package:pokemon/widget/Pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cubit/search_cubit.dart';

import 'package:pokemon/model/Pokemon.dart' show Pokemon;
import 'package:http/http.dart' as http;

void main() async {
  List item = [];
  List<Pokemon> pokemons = [];
  WidgetsFlutterBinding.ensureInitialized();
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/pokemon.json');
    final data = await json.decode(response);
    item=data;
  }
  await readJson();
  int POKEMON_LIST_SIZE = item.length;
  for (int i = 0; i < POKEMON_LIST_SIZE; ++i) {
    pokemons.add(Pokemon.fromJson(item[i]));
  }
  Pokedex POKEDEX = Pokedex(pokemons);
  runApp(myApp(pokedex: POKEDEX,));
}

class myApp extends StatelessWidget {
  final Pokedex pokedex;

  myApp({required this.pokedex});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      home: BlocProvider (
        create: (context) => searchCubit(pokedex),
        child: PokedexGridView(pokedex: pokedex,),
      ),
    );
  }
}

class PokedexGridView extends StatefulWidget {
  late final Pokedex pokedex;

  PokedexGridView({required this.pokedex});

  @override
  State<PokedexGridView> createState()=>_PokedexGridViewState();
}

class _PokedexGridViewState extends State<PokedexGridView> {
  final pokemonSearchingName = TextEditingController();
  String? _sortingDropDownValue = "Lowest Number";
  late final List<Pokemon> POKEMON_LIST = widget.pokedex.pokedex;
  late List<Pokemon> searchedPokemonsList = widget.pokedex.pokedex;
  void changeList() {
    setState(() {
      searchedPokemonsList = POKEMON_LIST;
      searchedPokemonsList.shuffle();
    });
  }
  int Compare(Pokemon a,Pokemon b,int type) { // Compare function for sorting
    if (type == 1) {
      if (a.id < b.id) return -1;
      else if (a.id > b.id) return 1;
      else return 0;
    }
    else {
      return a.name.compareTo(b.name);
    }
  }
  void onChanged(String? value) {
      searchedPokemonsList = POKEMON_LIST;
      _sortingDropDownValue = value;
      if (_sortingDropDownValue == "Lowest Number") {
        searchedPokemonsList.sort((a,b) => Compare(a, b,1));
      }
      else if (_sortingDropDownValue == "Highest Number") {
        searchedPokemonsList.sort((a,b) => -Compare(a,b,1));
      }
      else if (_sortingDropDownValue == "From A-Z") {
        searchedPokemonsList.sort((a,b) => Compare(a,b,2));
      }
      else{
        searchedPokemonsList.sort((a,b) => -Compare(a, b, 2));
      }
      setState(() {

      });
  }
  List<String> _sortingRequest = <String>['Lowest Number', 'Highest Number', 'From A-Z', 'From Z-A'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: BlocListener<searchCubit,state>(
        listener: (context,state) {
          if (state is searchInit) {

          }
          else if (state is searchState) { // search state
            searchedPokemonsList = state.result.pokedex; // get searched result
            if (_sortingDropDownValue == "Lowest Number") {
              searchedPokemonsList.sort((a,b) => Compare(a, b,1));
            }
            else if (_sortingDropDownValue == "Highest Number") {
              searchedPokemonsList.sort((a,b) => -Compare(a,b,1));
            }
            else if (_sortingDropDownValue == "From A-Z") {
              searchedPokemonsList.sort((a,b) => Compare(a,b,2));
            }
            else{
              searchedPokemonsList.sort((a,b) => -Compare(a, b, 2));
            }
            setState(() {

            });
          }
        },
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: pokemonSearchingName,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      final _cubit = BlocProvider.of<searchCubit>(context);
                      _cubit.searchPokemon(pokemonSearchingName.text);
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
                      value: _sortingDropDownValue,
                      items: _sortingRequest.map<DropdownMenuItem<String>>((String value){
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
            Expanded(child: GridView.count(crossAxisCount: 4,children: searchedPokemonsList.map((e) => pokemonTag(poketmonster: e)).toList(),
              childAspectRatio: 0.8,
            ),)
          ],
        )
      ),
    );
  }
  }