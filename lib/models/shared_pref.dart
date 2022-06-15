import 'package:shared_preferences/shared_preferences.dart';

class StoreSearch{
  SharedPreferences? _preferences;
  final String _keyword='Saved';

   Future init()async{
     _preferences=await SharedPreferences.getInstance();

    
  }
   Future saveSearch(List<String> keyword) async{
     _preferences=await SharedPreferences.getInstance();
    await _preferences!.setStringList(_keyword, keyword);
  }
    storeSearch() async{
       _preferences=await SharedPreferences.getInstance();
     _preferences?.getStringList(_keyword);
  }
}