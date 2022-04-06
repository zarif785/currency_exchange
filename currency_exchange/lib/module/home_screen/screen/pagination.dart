import 'package:currency_exchange/module/home_screen/service/home_screen_service.dart';
import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> with HomeScreenService {
  final controller =ScrollController();
  List items =[1,2,3,4,5,6,6,7,8,9,1,1,1,1,1];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      if(controller.position.maxScrollExtent==controller.offset){

      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: controller,
        itemCount: items.length+1,
        itemBuilder: (context,index){
          if(index<items.length){
            return ListTile(title: Text("a"));
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void navigateToFavoriteScreen() {
    // TODO: implement navigateToFavoriteScreen
  }

  @override
  void navigateToRecentScreen() {
    // TODO: implement navigateToRecentScreen
  }
}
