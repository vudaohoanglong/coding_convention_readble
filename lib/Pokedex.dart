

import 'pokemonClass.dart';

bool strcmp(String a, String b){
  a = a.toLowerCase();
  b = b.toLowerCase();
  if (a.length<b.length) return false;
  for (int i=0;i<b.length;++i){
    if (a[i]!=b[i]) return false;
  }
  return true;
}

class Pokedex{
  Pokedex(this.pokedex){
    n=pokedex.length;
  }
  List<Pokemon> pokedex = [];
  late int n;
  Pokedex search(String name){
    List<Pokemon> _result = [];
    for (int i=0;i<n;++i){
      if (strcmp(pokedex[i].name,name)){
        _result.add(pokedex[i]);
      }
    }
    return Pokedex(_result);
  }
}