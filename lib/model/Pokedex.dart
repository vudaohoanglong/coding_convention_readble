

import 'Pokemon.dart';

class Search {
  static bool compare(String dest, String given) { // function to find if given is prefix of dest
    if (given.length>dest.length) return false;
    else {
      return (given == dest.substring(0,given.length).toLowerCase());
    }
  }
}

class Pokedex {
  Pokedex(this.pokedex) {
    POKEDEX_SIZE=pokedex.length;
  }
  List<Pokemon> pokedex = [];
  late final int POKEDEX_SIZE;
  // basic search. Iterate all pokemon in pokedex and compare with the given name
  Pokedex search(String name) {
    List<Pokemon> _result = [];
    for (int i = 0; i < POKEDEX_SIZE; ++i){
      if (Search.compare(pokedex[i].name,name)) {
        _result.add(pokedex[i]);
      }
    }
    return Pokedex(_result);
  }
}