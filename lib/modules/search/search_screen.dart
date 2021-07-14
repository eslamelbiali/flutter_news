import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/shared/components/components.dart';
import 'package:flutter_news/shared/cubit/cubit.dart';
import 'package:flutter_news/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder:(context,state){

        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Search Must not be Empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefix: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: articleBuilder(
                  list,
                  context,
                  isSearch: true,
                ),
              ),

            ],
          ),
        );
      } ,
    );
  }
}
