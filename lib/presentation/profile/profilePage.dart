import 'package:chit_chat/presentation/profile/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_bloc/home_bloc.dart';
import '../home/home_bloc/home_event.dart';
import 'profileModel.dart';

class ProfilePage extends StatefulWidget {
  final int userId;
  final int log_user;
  ProfilePage({super.key, required this.userId, required this.log_user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(FetchUserProfile(userId: widget.userId));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .53,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image/profile_image.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 15,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ProfileLoaded) {
                        UserProfile userProfile = state.userProfile;
                        // print(userProfile
                        //     .customerData.interestStatus!.interestStatus);
                        // print(userProfile.customerData.interestStatus!.sender);
                        // print(widget.log_user);
                        return Positioned(
                            right: 15,
                            bottom: 5,
                            child:
                                userProfile.customerData.interestStatus == null
                                    ? sendIntrest(userProfile.customerData.id)
                                    : userProfile.customerData.interestStatus!
                                                    .interestStatus ==
                                                "pending" &&
                                            userProfile.customerData
                                                    .interestStatus!.sender ==
                                                widget.log_user
                                        ? requestSend()
                                        : userProfile
                                                        .customerData
                                                        .interestStatus!
                                                        .interestStatus ==
                                                    "pending" &&
                                                userProfile
                                                        .customerData
                                                        .interestStatus!
                                                        .sender !=
                                                    widget.log_user
                                            ? approveOrDecline(userProfile
                                                .customerData
                                                .interestStatus!
                                                .sender)
                                            : userProfile
                                                        .customerData
                                                        .interestStatus!
                                                        .interestStatus ==
                                                    "accepted"
                                                ? readyToChat()
                                                : Container());
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded) {
                  UserProfile userProfile = state.userProfile;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProfile.customerData.user.firstName,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userProfile.customerData.user.phone,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  );
                } else if (state is ProfileError) {
                  return Container(
                      height: 40, child: Center(child: Text(state.message)));
                }
                return SizedBox();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sendIntrest(int id) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HomeBloc>(context).add(Sendintrest(recieverId: id));
        context
            .read<ProfileBloc>()
            .add(FetchUserProfile(userId: widget.userId));
      },
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * .5,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "Send Interest",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  requestSend() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * .5,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 37, 129, 43),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          "Interest Send",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  approveOrDecline(int id) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            BlocProvider.of<HomeBloc>(context).add(acceptIntrest(userId: id));
            context
                .read<ProfileBloc>()
                .add(FetchUserProfile(userId: widget.userId));
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * .2,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 37, 129, 43),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
                child: Icon(
              Icons.check,
              color: Colors.white,
            )),
          ),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .2,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 129, 37, 37),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Icon(
            Icons.close,
            color: Colors.white,
          )),
        ),
      ],
    );
  }

  readyToChat() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * .4,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 37, 129, 43),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.chat,
            color: Colors.white,
          ),
          Text(
            "Chat",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
