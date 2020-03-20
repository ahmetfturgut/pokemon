import 'package:flutter/material.dart';

import 'model/pokedex.dart';

class PokemonDetail extends StatelessWidget {
  Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          pokemon.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height * (8 / 10),
            width: MediaQuery.of(context).size.width - 20,
            left: 10,
            top: MediaQuery.of(context).size.height * 0.06,
            child: Card(
              elevation: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Weight: " + pokemon.weight),
                  Text("Height: " + pokemon.height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((tip) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(tip),
                            ))
                        .toList(),
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution != null
                        ? pokemon.nextEvolution
                            .map((evolution) => Chip(
                                  label: Text(evolution.name),
                                  backgroundColor: Colors.deepOrange.shade300,
                                ))
                            .toList()
                        : [Text("Son Hali")],
                  ),
                  Text(
                    "Weaknesses",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses !=null?
                        pokemon.weaknesses.map((weaknesses) => Chip(
                            backgroundColor: Colors.deepOrange.shade300,
                            label: Text(weaknesses)))
                        .toList():[Text("Zayıflığı Yok")],
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: pokemon.img,
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.network(
                    pokemon.img,
                    fit: BoxFit.cover,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
