import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex/model/pokedex.dart';
import 'package:pokedex/pokemon_detail.dart';

class PokemonList extends StatefulWidget {
  PokemonList({Key key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;
  Future<Pokedex> veri;
  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: FutureBuilder(
          future: veri,
          builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
            if (gelenPokedex.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (gelenPokedex.connectionState == ConnectionState.done) {
              return GridView.count(
                crossAxisCount: 2,
                children: gelenPokedex.data.pokemon.map((poke) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PokemonDetail(pokemon: poke)));
                    },
                    child: Hero(
                        tag: poke.id,
                        child: Card(
                          elevation: 6,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  poke.name,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                poke.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22),
                              )
                            ],
                          ),
                        )),
                  );
                }).toList(),
              );
              // GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2),
              //     itemBuilder: (context, index) {
              //       return Text(gelenPokedex.data.pokemon[index].name);
              //     });
            }
          }),
    );
  }
}
