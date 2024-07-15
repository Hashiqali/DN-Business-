import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/user/home_screeen/home_screen.dart';
import 'package:detail_dex/screens/user/list_details/functions.dart';
import 'package:detail_dex/screens/user/list_details/list_tile.dart';
import 'package:detail_dex/widgets/loading_screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

final DetailsBloc homebloc = DetailsBloc();

class ListDetails extends StatelessWidget {
  const ListDetails({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: getDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(
                  fontFamily: 'dex2',
                  color: Colors.white,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w400),
            ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 255, 255, 255),
            ));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              'No data available',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'dex2',
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w400),
            ));
          } else {
            List details = snapshot.data ?? [];
            alldetails = snapshot.data ?? [];
            return BlocBuilder<DetailsBloc, DetailsState>(
              bloc: homebloc,
              builder: (context, state) {
                if (state is LoadingWidgetState) {
                  return const LoadingScreen();
                } else if (state is SearchedDetailsState) {
                  if (state.details.isEmpty) {
                    return Center(
                      child: Lottie.asset(
                          height: size.width / 2.2,
                          'assets/animation/no searched song animation.json'),
                    );
                  } else {
                    return ListView.builder(
                        padding: EdgeInsets.all(size.width / 40),
                        itemCount: state.details.length,
                        itemBuilder: (ctx, index) {
                          final data = state.details[index];

                          return listTile(
                              bloc: homebloc,
                              issearch: true,
                              size: size,
                              data: data,
                              context: context);
                        });
                  }
                }
                return ListView.builder(
                    padding: EdgeInsets.all(size.width / 40),
                    itemCount: details.length,
                    itemBuilder: (ctx, index) {
                      final data = details[index];

                      return listTile(
                          bloc: homebloc,
                          size: size,
                          data: data,
                          context: context,
                          issearch: false);
                    });
              },
            );
          }
        });
  }
}
