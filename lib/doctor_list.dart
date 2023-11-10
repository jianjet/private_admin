import 'package:admin/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatefulWidget {
  final String doctor_name;
  final bool verified_status;
  final String doctor_uid;
  final String ic;
  final String medicalID;
  final String email;

  DoctorList({
    required this.doctor_name,
    required this.verified_status,
    required this.doctor_uid,
    required this.ic,
    required this.medicalID,
    required this.email,
    Key? key
    }) : super(key: key);
  @override
  DoctorListState createState() => DoctorListState();
}

class DoctorListState extends State<DoctorList> {

  final firestoreInstance = FirebaseFirestore.instance;
  
  Future<void> _confirmed() async {
    DocumentReference docRef = firestoreInstance.collection('doctor_users').doc(widget.doctor_uid);
    try {
        await docRef.update({
        'verified_status': true
      });
    } on FirebaseException catch (e){
      Utils.showSnackbar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(border: Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 0.5
        )
      )),
      child: Container(
        padding: const EdgeInsets.only(left: 5,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('./image/girl_icon.png'),
                    maxRadius: 20,
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Name: ${widget.doctor_name}', style: const TextStyle(fontSize: 16)),
                          Text('IC: ${widget.ic}', style: const TextStyle(fontSize: 16)),
                          Text('Medical ID: ${widget.medicalID}', style: const TextStyle(fontSize: 16)),
                          Text('Email: ${widget.email}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  if (widget.verified_status==true) ... []
                  else ... [
                    TextButton(
                      onPressed: (){
                        _confirmed();
                      }, 
                      child: const Icon(Icons.check, size: 50, color: Colors.green,)
                    ),
                    // const SizedBox(width: 10),
                    // TextButton(
                    //   onPressed: (){
                        
                    //   }, 
                    //   child: const Icon(Icons.close_rounded, size: 50, color: Colors.red,)
                    // )
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}