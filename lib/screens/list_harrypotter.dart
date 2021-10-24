import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:juan_serna_9_2021_2_p1/components/loader_component.dart';
import 'package:juan_serna_9_2021_2_p1/helpers/api_helper.dart';
import 'package:juan_serna_9_2021_2_p1/models/response.dart';
import 'package:juan_serna_9_2021_2_p1/models/characters_potter.dart';
import 'package:juan_serna_9_2021_2_p1/screens/lists_details.dart';

class ListPotter extends StatefulWidget {
  
//final Characters characters;

  ListPotter();

  @override
  _ListPotterState createState() => _ListPotterState();
}

class _ListPotterState extends State<ListPotter> {
  String _search = '';
  bool _isFilter = false;
  bool _showLoader = false;
  List<CharactersHP> _characters = [];

void initState() {
    super.initState();
    _getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de personajes'),
        actions: <Widget>[
          _isFilter ? IconButton(
            onPressed: () => _removeFilter(),
            icon: Icon(Icons.filter_none),
          )
          : IconButton(
            onPressed: () => _showFilter(),
            icon: Icon(Icons.filter_alt),
          ),
        ],
        ),
        body: Center(
          child: _showLoader ? LoaderComponent(text: 'Por favor espere...',): _GetContent()
          ),
    );
  }

  void _removeFilter() {
   setState(() {
     _isFilter = false;
   });
   _getCharacters();
  }

  void _showFilter() {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10),
         ),  
         title: Text('Filtrar Personajes'),
         content: Column(
           mainAxisSize: MainAxisSize.min,
           children: <Widget>[
             Text('Escriba las primeras letras del personaje'),
             SizedBox(height: 10,),
             TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Criterio de busqueda...',
                labelText: 'Buscar',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                  _search = value;
              },
             ),
           ],
           ),
           actions: <Widget>[
             TextButton(
               onPressed: () => Navigator.of(context).pop(), 
               child: Text('Cancelar'),
               ),
                TextButton(
               onPressed: () => _filter(), 
               child: Text('Filtrar'),
               ),
           ],
           
        );
      });
    }

  void _filter() {
    if(_search.isEmpty){
      return;
    }

    List<CharactersHP> filteredList = [];
    for (var character in _characters) {
      if(character.name.toLowerCase().contains(_search.toLowerCase())){
        filteredList.add(character);
      }
    }

    setState(() {
      _characters = filteredList;
      _isFilter = true;
    });

    Navigator.of(context).pop();
  }
   
  Future<Null> _getCharacters() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'Verifica que estes conectado a internet.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    Response response = await ApiHelper.getCharacters(); 
    setState(() {
        _showLoader = false;
      });

    if(!response.isSuccess)
    {
      await showAlertDialog(
        context: context,
        title: 'Error',
        message: response.message,
        actions: <AlertDialogAction>[
          AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );
      return;
    }

    setState(() {
      _characters = response.result;
    });
  }

 Widget _GetContent() {
    return _characters.length == 0
    ? _noContent()
    : _getListView();
  }

  Widget _noContent() {
  return Center(
    child: Container(
      margin: EdgeInsets.all(20),
      child: Text(
        _isFilter
        ? 'No hay personajes con ese criterio de busqueda.'
        : 'No hay personajes registradas',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      ),
    ),
  );
  }

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getCharacters,
      child: ListView(
        children: _characters.map((e) {
          return Card(
            child: InkWell(
              onTap: () => _goDetail(e),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: e.image == ''
                      ? 
                      Image(
                          image: AssetImage('assets/no-image.png'),
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        )
                      :
                      CachedNetworkImage(
                        imageUrl: e.image,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  e.name, 
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  e.gender, 
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  e.house, 
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _goDetail(CharactersHP character) async {
   String? result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => CharacterInfoScreen(
          charactersHP: character,
        )
      )
    );
    if (result == 'yes') {
      _getCharacters();
    }
 }

}