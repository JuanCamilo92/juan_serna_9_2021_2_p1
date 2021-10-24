import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:juan_serna_9_2021_2_p1/components/loader_component.dart';
import 'package:juan_serna_9_2021_2_p1/helpers/api_helper.dart';
import 'package:juan_serna_9_2021_2_p1/models/characters_potter.dart';
import 'package:juan_serna_9_2021_2_p1/models/response.dart';

class CharacterInfoScreen extends StatefulWidget {
  final CharactersHP charactersHP;

  CharacterInfoScreen({required this.charactersHP});

  @override
  _CharacterInfoScreenState createState() => _CharacterInfoScreenState();
}

class _CharacterInfoScreenState extends State<CharacterInfoScreen> {
  bool _showLoader = false;
  late CharactersHP _charactersHP;

  @override
  void initState() {
    super.initState();
    _charactersHP = widget.charactersHP;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_charactersHP.name),
      ),
      body: Center(
        child: _showLoader 
          ? LoaderComponent(text: 'Por favor espere...',) 
          : _showCharacterInfo(),
      ),
    );
  }

  Widget _showCharacterInfo() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Nombre: ', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )
                                ),
                                Text(
                                  _charactersHP.name, 
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Genero: ', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )
                                ),
                                Text(
                                  _charactersHP.gender, 
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Casa: ', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )
                                ),
                                Text(
                                  _charactersHP.house, 
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Especie: ', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )
                                ),
                                Text(
                                  _charactersHP.species, 
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Año de nacimiento: ', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )
                                ),
                                Text(
                                  _charactersHP.yearOfBirth.toString() , 
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Color de cabello: ', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  )
                                ),
                                Text(
                                  _charactersHP.hairColour, 
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: _charactersHP.image == ''
                ? 
                 Image(
                    image: AssetImage('assets/no-image.png'),
                    fit: BoxFit.cover,
                    height: 400,
                  )
                :
                CachedNetworkImage(
                  imageUrl: _charactersHP.image,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: 400,
                ),
              ),
          ],
        )
      ],
    );
  }




}