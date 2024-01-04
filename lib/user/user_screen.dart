// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:awesome_card/awesome_card.dart';
import 'package:dummy_api/user/user_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserDataModel? userDataModel;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    var uri = Uri.parse('https://dummyjson.com/users');
    var resonse = await httpClient.get(uri);

    if (resonse.statusCode == 200) {
      userDataModel = UserDataModel.fromJson(jsonDecode(resonse.body));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade100,
        appBar: AppBar(title: Text('User Database'),
          backgroundColor: Colors.green.shade200,
        ),
        body: userDataModel != null && userDataModel!.users.isNotEmpty
            ? ListView.builder(
                itemCount: userDataModel!.users.length,
                itemBuilder: (_, index) {
                  UserModel apiPath = userDataModel!.users[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return UserProfileView(
                              apiPath: apiPath,
                            );
                          },
                        ));
                      },
                      tileColor: Colors.green.shade200,
                      leading: Text(
                        'Id : ${apiPath.id}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Name : ${userDataModel!.users[index].firstName} ${userDataModel!.users[index].maidenName}'),
                          Text("Email : ${userDataModel!.users[index].email}"),
                        ],
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text('No Users Found'),
              ));
  }
}

class UserProfileView extends StatefulWidget {
  UserProfileView({super.key, required this.apiPath});
  UserModel apiPath;

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  bool passwordSee = true;
  bool frontSideCard = false;
  @override
  Widget build(BuildContext context) {
    var bank = widget.apiPath.bank!;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              profileIconAndText(),
              userDetails(),
              personalDetails(),
              addressList(),
              companyDetails(),
              bankCard(bank),
              technicalDetails(),
              const SizedBox(height: 60)
            ],
          ),
        ));
  }

  ExpansionTile technicalDetails() {
    return myExpensionView([
      Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Divider(),
            customProfileDetailsRow(
                name: 'Domain : ', path: widget.apiPath.domain!),
            const Divider(),
            customProfileDetailsRow(name: 'IP : ', path: widget.apiPath.ip),
            const Divider(),
            customProfileDetailsRow(
                name: 'MAC : ', path: widget.apiPath.macAddress!),
            const Divider(),
            customProfileDetailsRow(name: 'EIN : ', path: widget.apiPath.ein!),
            const Divider(),
            customProfileDetailsRow(name: 'SSN : ', path: widget.apiPath.ssn!),
            const Divider(),
            Text(
              'User Agent : ${widget.apiPath.userAgent!}',
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        ),
      )
    ], 'Technical Details');
  }

  Padding userDetails() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Divider(),
          customProfileDetailsRow(
              name: 'Phone Number : ', path: widget.apiPath.phone!),
          const Divider(),
          customProfileDetailsRow(
              name: 'Email : ', path: widget.apiPath.email!),
          const Divider(),
          myPasswordPersonalDetailsRow(),
          const Divider(),
        ],
      ),
    );
  }

  ExpansionTile personalDetails() {
    return myExpensionView([
      Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customProfileDetailsRow(
                name: 'Name : ',
                path:
                    '${widget.apiPath.firstName!} ${widget.apiPath.lastName!} '),
            const Divider(),
            customProfileDetailsRow(
                name: 'University : ', path: widget.apiPath.university!),
            const Divider(),
            customProfileDetailsRow(
                name: 'Gender : ', path: widget.apiPath.gender!),
            const Divider(),
            customProfileDetailsRow(name: 'Age : ', path: widget.apiPath.age),
            const Divider(),
            customProfileDetailsRow(
                name: 'Birth Date : ', path: widget.apiPath.birthDate!),
            const Divider(),
            customProfileDetailsRow(
                name: 'Blood Group : ', path: widget.apiPath.bloodGroup!),
            const Divider(),
            customProfileDetailsRow(
                name: 'Height : ', path: widget.apiPath.height!),
            const Divider(),
            customProfileDetailsRow(
                name: 'Weight : ', path: widget.apiPath.weight!),
            const Divider(),
            customProfileDetailsRow(
                name: 'Eye Color : ', path: widget.apiPath.eyeColor!),
            const Divider(),
            customProfileDetailsRow(
                name: 'Hair Color : ', path: widget.apiPath.hair!.color),
            const Divider(),
            customProfileDetailsRow(
                name: 'Hair Type : ', path: widget.apiPath.hair!.type),
            const Divider(),
          ],
        ),
      )
    ], 'Personal Details');
  }

  Padding myPasswordPersonalDetailsRow() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Password : '.toString(),
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Row(
            children: [
              Text(
                (passwordSee ? widget.apiPath.password! : '**********')
                    .toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      passwordSee = !passwordSee;
                    });
                  },
                  icon: Icon(passwordSee == true
                      ? Icons.remove_red_eye
                      : Icons.lock_rounded)),
            ],
          ),
        ],
      ),
    );
  }

  Padding customProfileDetailsRow({required String name, required var path}) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name.toString(),
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            path.toString(),
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }

  ExpansionTile companyDetails() {
    return myExpensionView([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            customProfileDetailsRow(
                name: 'Company Name : ',
                path: widget.apiPath.company!.name!.toString()),
            const Divider(),
            customProfileDetailsRow(
                name: 'Title : ',
                path: widget.apiPath.company!.title!.toString()),
            const Divider(),
            customProfileDetailsRow(
                name: 'Department : ',
                path: widget.apiPath.company!.department!.toString()),
            const Divider(),
            ExpansionTile(
              // childrenPadding: const EdgeInsets.all(10),
              controller: ExpansionTileController(),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.topLeft,
              shape: const RoundedRectangleBorder(side: BorderSide.none),
              // collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
              title: const Text('Company Address'),
              children: [
                const Divider(),
                customProfileDetailsRow(
                    name: 'Stats : ',
                    path: widget.apiPath.company!.address!.state!.toString()),
                const Divider(),
                customProfileDetailsRow(
                    name: 'City : ',
                    path: widget.apiPath.company!.address!.city!.toString()),
                const Divider(),
                customProfileDetailsRow(
                    name: 'Address : ',
                    path: widget.apiPath.company!.address!.address!.toString()),
                const Divider(),
                customProfileDetailsRow(
                    name: 'Postal Code : ',
                    path: widget.apiPath.company!.address!.postalCode!
                        .toString()),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      )
    ], 'Company Details');
  }

  Column profileIconAndText() {
    return Column(
      children: [
        CircleAvatar(
            radius: 70, child: Image.network(widget.apiPath.image.toString())),
        const SizedBox(height: 10),
        Text(
          "${widget.apiPath.firstName} ${widget.apiPath.lastName}",
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  ExpansionTile bankCard(
    BankModel bank,
  ) {
    return myExpensionView([
      InkWell(
        onTap: () {
          frontSideCard = !frontSideCard;
          setState(() {});
        },
        child: CreditCard(
          bankName: bank.cardType.toString(),
          showBackSide: frontSideCard,
          textName: widget.apiPath.firstName,
          horizontalMargin: 7,
          height: 240,
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
          cardNumber: addSpaces(widget.apiPath.bank!.cardNumber.toString()),
          cardExpiry: bank.cardExpire,
          cardHolderName:
              "${widget.apiPath.firstName} ${widget.apiPath.lastName}",
          cardType: CardType.masterCard,
          cvv: 324.toString(),
        ),
      ),
      const SizedBox(height: 10),
    ], 'Bank Card');
  }

  ExpansionTile addressList() {
    return myExpensionView([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Divider(),
            customProfileDetailsRow(
                name: 'Stats : ',
                path: widget.apiPath.address!.state!.toString()),
            const Divider(),
            customProfileDetailsRow(
                name: 'City : ',
                path: widget.apiPath.address!.city!.toString()),
            const Divider(),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Address : "),
                  Text(
                    '${widget.apiPath.address!.address}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
            ),
            const Divider(),
            customProfileDetailsRow(
                name: 'Postal Code : ',
                path: widget.apiPath.address!.postalCode!.toString()),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ], 'Address');
  }

  ExpansionTile myExpensionView(List<Widget> childs, String name) {
    return ExpansionTile(
      // childrenPadding: const EdgeInsets.all(10),
      controller: ExpansionTileController(),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.topLeft,
      // shape: const RoundedRectangleBorder(side: BorderSide.none),
      // collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: childs,
    );
  }

  String addSpaces(String cardNumber) {
    return cardNumber.replaceAllMapped(
      RegExp(r".{4}"),
      (match) => "${match.group(0)} ",
    );
  }
}
