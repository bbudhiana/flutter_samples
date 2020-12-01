import 'package:flutter/material.dart';

class ListSubject extends StatelessWidget {
  final int number;
  final String title;
  final String subTitle;
  final IconData iconSubject;
  final String route;

  const ListSubject(
      {Key key,
      this.number,
      this.title,
      this.subTitle,
      this.iconSubject,
      this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        child: ListTile(
          leading: CircleAvatar(
            child: Text(number.toString()),
          ),
          title: Text(title),
          subtitle: Text(subTitle),
          isThreeLine: true,
          trailing: IconButton(
            icon: Icon(iconSubject),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

/*
ListSubject(
            number: _i++,
            title: 'Post With HTTP',
            subTitle: 'Post With HTTP',
            iconSubject: Icons.add,
            route: PostScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Get With HTTP',
            subTitle: 'Melakukan Get dengan HTTP, dari https://reqres.in/',
            iconSubject: Icons.get_app,
            route: GetScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Get Many With HTTP',
            subTitle: 'Melakukan Get many dengan HTTP, dari https://reqres.in/',
            iconSubject: Icons.all_out,
            route: GetManyScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Try Widget',
            subTitle: 'Testing Widget',
            iconSubject: Icons.event,
            route: TryWidgetScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Switch Sample',
            subTitle: 'Switch Sample',
            iconSubject: Icons.switch_camera,
            route: SwitchScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Share Preferences',
            subTitle: 'Untuk simpan data simple',
            iconSubject: Icons.stay_primary_landscape,
            route: SharedPreferencesScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Provider State Management',
            subTitle: 'Untuk contoh Provider State Management',
            iconSubject: Icons.system_update,
            route: StateManagementScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Bloc State Management 1 - tanpa library',
            subTitle: 'Bloc 1',
            iconSubject: Icons.block,
            route: BlocOneScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Bloc State Management 2 - with library and hydrated',
            subTitle: 'Bloc 2',
            iconSubject: Icons.block,
            route: BlocTwoScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Timer',
            subTitle: 'Menggunakan Timer',
            iconSubject: Icons.timer,
            route: TimerScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Progress Bar with Provider and Timer',
            subTitle:
                'Membuat Progress Bar dengan kombinasi Provider dan Timer',
            iconSubject: Icons.timer,
            route: ProgressBarProvider.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Card with message',
            subTitle: 'Membuat Widget Dard dengan Message',
            iconSubject: Icons.timer,
            route: CardWithMessageScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Listview Builder and BLoC',
            subTitle: 'Listview dengan BLoC',
            iconSubject: Icons.list,
            route: ListviewBlocScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'MVVM with BLoC',
            subTitle: 'Menggunakan MVVM dengan BLoC',
            iconSubject: Icons.block,
            route: MvvmScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'MultiBLoC in Multipage',
            subTitle: 'Multi BLoC dalam aplikasi Multipage',
            iconSubject: Icons.rowing,
            route: MultiblocScreen.routeName,
          ),

          ListTile(
            leading: CircleAvatar(
              child: Text('1'),
            ),
            title: Text('Post With HTTP'),
            subtitle:
                Text('Melakukan Post dengan HTTP, dari https://reqres.in/'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(PostScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('2'),
            ),
            title: Text('Get With HTTP'),
            subtitle:
                Text('Melakukan Get dengan HTTP, dari https://reqres.in/'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.get_app),
              onPressed: () {
                Navigator.of(context).pushNamed(GetScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('3'),
            ),
            title: Text('Get Many With HTTP'),
            subtitle:
                Text('Melakukan Get many dengan HTTP, dari https://reqres.in/'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.all_out),
              onPressed: () {
                Navigator.of(context).pushNamed(GetManyScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('4'),
            ),
            title: Text('Try Widget'),
            subtitle: Text('Testing Widget'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.event),
              onPressed: () {
                Navigator.of(context).pushNamed(TryWidgetScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('5'),
            ),
            title: Text('Switch Sample'),
            subtitle: Text('Switch Sample'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.switch_camera),
              onPressed: () {
                Navigator.of(context).pushNamed(SwitchScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('6'),
            ),
            title: Text('Share Preferences'),
            subtitle: Text('Untuk simpan data simple'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.stay_primary_landscape),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(SharedPreferencesScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('7'),
            ),
            title: Text('Provider State Management'),
            subtitle: Text('Untuk contoh Provider State Management'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.system_update),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(StateManagementScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('8'),
            ),
            title: Text('Bloc State Management 1 - tanpa library'),
            subtitle: Text('Bloc 1'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.block),
              onPressed: () {
                Navigator.of(context).pushNamed(BlocOneScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('9'),
            ),
            title: Text('Bloc State Management 2 - with library and hydrated'),
            subtitle: Text('Bloc 2'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.block),
              onPressed: () {
                Navigator.of(context).pushNamed(BlocTwoScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('10'),
            ),
            title: Text('Timer'),
            subtitle: Text('Menggunakan Timer'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                Navigator.of(context).pushNamed(TimerScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('11'),
            ),
            title: Text('Progress Bar with Provider and Timer'),
            subtitle: Text(
                'Membuat Progress Bar dengan kombinasi Provider dan Timer'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                Navigator.of(context).pushNamed(ProgressBarProvider.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('12'),
            ),
            title: Text('Card with message'),
            subtitle: Text('Membuat Widget Dard dengan Message'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(CardWithMessageScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('13'),
            ),
            title: Text('Listview Builder and BLoC'),
            subtitle: Text('Listview dengan BLoC'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).pushNamed(ListviewBlocScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('14'),
            ),
            title: Text('MVVM with BLoC'),
            subtitle: Text('Menggunakan MVVM dengan BLoC'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.block),
              onPressed: () {
                Navigator.of(context).pushNamed(MvvmScreen.routeName);
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('15'),
            ),
            title: Text('MultiBLoC in Multipage'),
            subtitle: Text('Multi BLoC dalam aplikasi Multipage'),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.rowing),
              onPressed: () {
                Navigator.of(context).pushNamed(MultiblocScreen.routeName);
              },
            ),
          ),
*/
