import 'package:flutter/material.dart';

import 'package:pokemon/model/Pokemon.dart';

import 'package:pokemon/Type.dart';


String intFixed(int n, int count) => n.toString().padLeft(count, "0"); // fixed length of number


Widget pokemonTag({required Pokemon poketmonster}) {
  return Wrap(
    children: [
      Container(
        //color: Colors.red,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          'assets/images/${intFixed(poketmonster.id, 3)}.png',
          width: 50,
          height: 50,
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        //color: Colors.red,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            '#${intFixed(poketmonster.id, 3)}',
            style: const TextStyle(fontSize: 5) ,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        //color: Colors.yellow,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            poketmonster.name,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ),
      Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: poketmonster.type.map((e) => typeTag(e)).toList()
      )
    ],
  );
}

