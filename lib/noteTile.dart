import 'package:flutter/material.dart';
import 'package:try_new/DbHelper.dart';
import 'package:try_new/homePage.dart';
import 'package:try_new/noteModel.dart';
class NoteTile extends StatelessWidget {
  NoteTile({Key? key}) : super(key: key);
  GlobalKey formKey=GlobalKey<FormState>();
  TextEditingController title=TextEditingController(),
  desc=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500,color: Colors.black,letterSpacing: 2)),
        backgroundColor:Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){
            if(title.text.isNotEmpty){
              DateTime dt=DateTime.now();
              DbHelper.insertNote(Note(title: title.text, desc: desc.text,date: "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute}"));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomePage()));
            }
          }, child: Text("Save".toUpperCase(),style: const TextStyle(fontSize:16,fontWeight: FontWeight.w400,letterSpacing: 0.8),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:Form(
          key:formKey,
          child: Column(
            children: [
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle:const TextStyle(color: Colors.grey),
                  prefixIcon:const  Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.cyan)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.cyan)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.cyan)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.cyan)),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: desc,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle:const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.cyan)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.cyan)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.cyan)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.cyan)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
