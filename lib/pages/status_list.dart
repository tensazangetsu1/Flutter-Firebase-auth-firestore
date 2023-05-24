import 'package:chatapp/firebase_service/status_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatusListPage extends StatefulWidget {
  const StatusListPage({Key? key}) : super(key: key);

  @override
  State<StatusListPage> createState() => _StatusListPageState();
}

class _StatusListPageState extends State<StatusListPage> {
  final StatusService _statusService = StatusService();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: _statusService.getStatus(),
      builder: (context, snaphot) {
        return !snaphot.hasData
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: snaphot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snaphot.data!.docs[index];

                  Future<void> showChoiseDialog(BuildContext context) {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text(
                                "Silmek istediğinize emin misiniz?",
                                textAlign: TextAlign.center,
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              content: Container(
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          _statusService
                                              .removeStatus(mypost.id);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Evet",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Vazgeç",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )));
                        });
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showChoiseDialog(context);
                      },
                      child: Container(
                        height: size.height * .3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${mypost['status']}",
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: CircleAvatar(
                                backgroundImage: NetworkImage(mypost['image']),
                                radius: size.height * 0.08,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
      },
    );
  }
}
