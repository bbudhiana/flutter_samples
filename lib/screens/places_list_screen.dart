import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../provider/great_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great Places - implement Google Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routename);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        //LOAD DATANYA dan tidak perlu rebuild karena ada consumer
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        //GET SNAPSHOT NYA, jika wait maka tampilkan loading, jika snapshot nya done maka Consumer Build widget kembali
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                //child : not updates this part when data changes
                child: Center(
                  child: Text(
                    'Got no places yet, start adding some!',
                  ),
                ),
                builder: (context, greatPlaces, ch) =>
                    greatPlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[i].image),
                              ),
                              title: Text(greatPlaces.items[i].title),
                              subtitle:
                                  Text(greatPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatPlaces.items[i].id,
                                );
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
