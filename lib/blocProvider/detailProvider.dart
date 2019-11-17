/*
  This is the main Screen Provider, it is the Class to Call if you want to diplay the Main Screen
  Only Task is to show the Real Main Screen widget and provide the Bloc to it
*/
/*
class DetailScreenProvider extends StatefulWidget {
  DetailScreenProvider({@required this.activity, Key key}) : super(key: key);

  Activity activity;
  DetailScreenProviderState createState() => DetailScreenProviderState();
}

class DetailScreenProviderState extends State<DetailScreenProvider> {
  final myBloc = BLocDetailScreen();
  @override
  Widget build(BuildContext context) {
    //homeScreen is the Home Screen Widget (Scaffold)
    return BlocProvider(
        bloc: myBloc, child: DetailScreen(activity: widget.activity));
  }
}
*/
