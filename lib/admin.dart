import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'doctor_list.dart';
import 'errorpage.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);
  @override
  AdminState createState() => AdminState();
}

class AdminState extends State<Admin> with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _verificationList(bool verified_status){
    return Container(
      margin: const EdgeInsets.all(0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection('doctor_users')
        .where('verified_status', isEqualTo: verified_status)
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError){
            return const ErrorPage();
          }
          else if (!snapshot.hasData){
            return Container();
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(top: 0),
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                return DoctorList(
                  verified_status: document['verified_status'],
                  doctor_name: document['Name'],
                  doctor_uid: document['uid'],
                  ic: document['IC'],
                  medicalID: document['medID'],
                  email: document['Email'],
                );
              },
            );
          }
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       Navigator.push(context, MaterialPageRoute(builder: ((context) => const Others())));
        //     }, 
        //     icon: const Icon(Icons.add)
        //   )
        // ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: "Unconfirmed",),
            Tab(text: "Confirmed",)
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _verificationList(false),
          _verificationList(true),
        ],
      )
    );
  }
}