import 'package:bai_test_map/repository/map_repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AutosuggestScreen extends StatefulWidget {
  @override
  _AutosuggestScreenState createState() => _AutosuggestScreenState();
}

class _AutosuggestScreenState extends State<AutosuggestScreen> {
  TextEditingController _controller = TextEditingController();
  List _suggestions = [];
  MapRepository _apiService = MapRepository();

  void _fetchSuggestions(String query) async {
    List<dynamic> suggestions = await _apiService.fetchSuggestions(query);
    setState(() {
      _suggestions = suggestions;
    });
  }

  void _openGoogleMaps(String placeName) async {
    final query = Uri.encodeComponent(placeName);
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autosuggest App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1,10),
                      color: Colors.grey.withOpacity(0.2),
                    )
                  ]
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Enter keyword",
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        _suggestions = [];
                      });
                    },
                  )
                      : null,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.white,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.white,
                      )
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (text) {
                  if (text.length > 2) {
                    _fetchSuggestions(text);
                  } else {
                    setState(() {
                      _suggestions = [];
                    });
                  }
                },

              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  final title = suggestion['title'];
                  final address = suggestion['address']['label'];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 6.0), // Điều chỉnh khoảng cách giữa các phần tử
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        Expanded(
                          child: ListTile(
                            title: Text(title),
                            subtitle: Text(address),
                            // onTap: () {
                            //   _openGoogleMaps(title);
                            // },
                          ),
                        ),
                        IconButton(
                            onPressed: () => _openGoogleMaps(title),
                            icon: Icon(Icons.directions))
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}