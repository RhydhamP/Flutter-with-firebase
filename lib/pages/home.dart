import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/employee.dart';
import 'package:flutter_firebase/pages/login.dart';
import 'package:flutter_firebase/service/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  Stream? employeeStream;

  getontheload() async {
    employeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
      stream: employeeStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Name : ${ds["Name"]}",
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    nameController.text = ds['Name'];
                                    ageController.text = ds['Age'];
                                    locationController.text = ds['Location'];

                                    editEmployeeDetail(ds['Id']);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await DatabaseMethods()
                                        .deleteEmployeeDetail(ds['Id']);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "Age : ${ds["Age"]}",
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Location : ${ds["Location"]}",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Employee(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 4,
            ),
            const Text(
              "Flutter",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Firebase",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 22),
                )),
            const SizedBox(
              width: 6,
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          children: [Expanded(child: allEmployeeDetails())],
        ),
      ),
    );
  }

  Future editEmployeeDetail(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      "Edit ",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Details",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Name :",
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Age :",
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: ageController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Location :",
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: locationController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateInfo = {
                            "Name": nameController.text,
                            "Age": ageController.text,
                            "Id": id,
                            "Location": locationController.text
                          };
                          await DatabaseMethods()
                              .updateEmployeeDetail(id, updateInfo)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Update")))
              ],
            ),
          ),
        ),
      );
}
