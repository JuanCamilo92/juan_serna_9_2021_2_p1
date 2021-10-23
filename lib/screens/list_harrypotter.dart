import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:juan_serna_9_2021_2_p1/components/loader_component.dart';
import 'package:juan_serna_9_2021_2_p1/helpers/api_helper.dart';
import 'package:juan_serna_9_2021_2_p1/models/response.dart';
import 'package:juan_serna_9_2021_2_p1/models/characters_potter.dart';

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

  _removeFilter() {}

  _showFilter() {}

   
  Future<Null> _getCharacters() async {
    setState(() {
      _showLoader = true;
    });
    
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
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.name,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
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
   /*String? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder : (context) => BrandScreen(
          token: widget.token, 
          brand: brand,
        ),
      ),
    );

    if(result == 'yes'){
      _getCharacters();
    }*/
 }

}