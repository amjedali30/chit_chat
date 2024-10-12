import 'package:chit_chat/presentation/home/home_bloc/home_bloc.dart';
import 'package:chit_chat/presentation/profile/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constand/string.dart';
import 'home_bloc/home_event.dart';
import 'home_bloc/home_state.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  int user_Id = 0;
  @override
  void initState() {
    getUserId();

    // TODO: implement initState
    var data = BlocProvider.of<HomeBloc>(context).add(FetchAllMatches());
    super.initState();
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    user_Id = prefs.getInt('user_id') as int;
    print(user_Id);
    print(user_Id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child:
                            Image(image: AssetImage("assets/image/logoo.png")),
                      ),
                      SizedBox(width: 10),
                      Text("Chit-Chat")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Intract With Your",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blueGrey,
                                  fontSize: 16),
                            ),
                            Text(
                              " Happiness !",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 235, 75, 39),
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Icon(Icons.menu)
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 242, 242, 242),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          hintText: 'Search for Partner',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Matches",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15),
                      ),
                      Text(
                        "See All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 235, 75, 39),
                            fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      print(state);
                      if (state is MatchLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is MatchLoaded) {
                        final matches = state.matches;

                        return SizedBox(
                          height: MediaQuery.of(context).size.height * .26,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: matches.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final userMatch = matches[index];

                              return Container(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage(
                                                      userId: userMatch.id,
                                                      log_user: user_Id,
                                                    )));
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .35,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/image/profile_image.jpeg"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.7),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 15,
                                              top: 15,
                                              child: Container(
                                                  color: Colors.grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ),
                                            Positioned(
                                              left: 10,
                                              bottom: 10,
                                              child: Container(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    userMatch.userData.username,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    userMatch.userData.phone,
                                                    // "28 yrs , 6\"4'",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 12),
                                                  ),
                                                  // Text(
                                                  //   "Kozikode,Kerala",
                                                  //   style: TextStyle(
                                                  //       fontWeight: FontWeight.w400,
                                                  //       color: Color.fromARGB(
                                                  //           255, 255, 255, 255),
                                                  //       fontSize: 12),
                                                  // ),
                                                ],
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    userMatch.interest_status == null
                                        ? sendIntrest(userMatch.id)
                                        : userMatch.interest_status!
                                                        .interestStatus ==
                                                    "pending" &&
                                                userMatch.interest_status!
                                                        .sender ==
                                                    user_Id
                                            ? alreadySend()
                                            : userMatch.interest_status!
                                                            .interestStatus ==
                                                        "pending" &&
                                                    userMatch.interest_status!
                                                            .sender !=
                                                        userMatch.userData.id
                                                ? acceptOrRejectBtn(
                                                    context,
                                                    userMatch.interest_status!
                                                        .sender)
                                                : userMatch.interest_status!
                                                            .interestStatus ==
                                                        "accepted"
                                                    ? Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .05,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .35,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255)),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Icon(
                                                                Icons.chat,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    50,
                                                                    42,
                                                                    42),
                                                              ),
                                                              Text(
                                                                "Chat",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            73,
                                                                            69,
                                                                            69),
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container()
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is MatchError) {
                        return Center(
                            child: Text('Failed to load matches: ${state}'));
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sendIntrest(int id) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HomeBloc>(context).add(Sendintrest(recieverId: id));
        var data = BlocProvider.of<HomeBloc>(context).add(FetchAllMatches());
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .05,
        width: MediaQuery.of(context).size.width * .35,
        decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
        child: Center(
          child: Text(
            "Send Interest",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.orange,
                fontSize: 14),
          ),
        ),
      ),
    );
  }

  alreadySend() {
    return Container(
      height: MediaQuery.of(context).size.height * .05,
      width: MediaQuery.of(context).size.width * .35,
      decoration: BoxDecoration(color: Colors.green),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
            ),
            Text(
              "Interest Send",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  acceptOrRejectBtn(BuildContext context, userId) {
    return Container(
      width: MediaQuery.of(context).size.width * .35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<HomeBloc>(context)
                  .add(acceptIntrest(userId: userId));
              var data =
                  BlocProvider.of<HomeBloc>(context).add(FetchAllMatches());
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width * .15,
              decoration: BoxDecoration(color: Colors.green),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<HomeBloc>(context)
                  .add(declineIntrest(userId: userId));
              var data =
                  BlocProvider.of<HomeBloc>(context).add(FetchAllMatches());
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width * .15,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 181, 43, 43)),
              child: Center(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
