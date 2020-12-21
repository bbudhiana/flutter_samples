import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/user_provider.dart';

class FutureProviderBuilderScreen extends StatelessWidget {
  static const routeName = '/future-provider-builder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Provider and FuiterBuilder'),
      ),
      body: MultiProvider(
        providers: [
          //ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          //FutureProvider<typeData> jadi ini type data yg di return dari create (yg menerima return sebuah Future)
          FutureProvider<List<User>>(
            create: (context) => UserProvider().loadUserData(),
            initialData: [],
          ),
        ],
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //proses ambil data dimulai disini, namun karena feature tetap build
    //var _users = Provider.of<List<User>>(context);
    int _count = 0; // used by StreamBuilder
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('FutureProvider Example, users loaded from a File'),
        ),
        Consumer<List<User>>(
          builder: (context, usersData, _) => Expanded(
            //saat ambil data dalam proses maka beri loading indikator, setelah selesai build widget nya (ListView)
            child: usersData.isEmpty
                ? Center(
                    child: Container(
                        child: CupertinoActivityIndicator(radius: 50.0)),
                  )
                : ListView.builder(
                    itemCount: usersData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        color: Colors.grey[(index * 200) % 400],
                        child: Center(
                          child: Text(
                              '${usersData[index].firstName} ${usersData[index].lastName} | ${usersData[index].website}'),
                        ),
                      );
                    },
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('FutureBuilder Example, users loaded from a File'),
        ),
        Expanded(
          /**
           * Tiga state dalam FutureBuilder
           * 1. connectionState.none = In this state future is null 
           * 2. connectionState.waiting = [future] is not null, but has not yet completed
           * 3. connectionState.done = [future] is not null, and has completed. If the future completed successfully, 
           *    the [AsyncSnapshot.data] will be set to the value to which the future completed.
           */
          child: FutureBuilder(
            future: UserProvider().loadUserData(),
            //future: Provider.of<UserProvider>(context, listen: false).loadUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                //if (snapshot.error != null) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  //ambil datanya saat snapshot nya done kemudian langsung build ListView
                  //snapshot.data hanya dihasilkan ketika snapshot connection state nya adalah 'done'
                  var usersData = snapshot.data;
                  return ListView.builder(
                    itemCount: usersData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        color: Colors.grey[(index * 200) % 400],
                        child: Center(
                          child: Text(
                              '${usersData[index].firstName} ${usersData[index].lastName} | ${usersData[index].website}'),
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
        /*
          Dibawah ini adalah contoh StreamBuilder, ada beberapa hal :
          1. coba lihat untuk FutureProvider, setelah proses ambil data selesai maka rebuild mulai dari awal lagi, karena tidak gunakan Consumer
             jika gunakan consumer maka proses hanya rebuild dari dalam Consumer
          2. coba lihat untuk FutureBuilder, setelah proses ambil data selesai maka rebuild  mulai dari ListView.Builder
          3. StreamBuilder selalu lihat/listen perubahan datanya, membuatnya terus menerus menghandle perubahan data

          state dalam StreamBuilder :
          The usual flow of state is as follows:

          [none], maybe with some initial data.
          [waiting], indicating that the asynchronous operation has begun, typically with the data being null.
          [active], with data being non-null, and possible changing over time.
          [done], with data being non-null.
          
        */
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('StreamBuilder Example, count selalu bertambah'),
        ),
        Center(
          child: StreamBuilder<int>(
            stream: UserProvider().stopwatch(_count),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active)
                //kembaliannya/perubahannya terus menerus di cek atau di listen
                return Text("Stopwatch = ${snapshot.data}");

              return CircularProgressIndicator();
            },
          ),
        )
      ],
    );
  }
}
