import 'package:connectivity/connectivity.dart';
import 'package:detail_dex/screens/user/bloc/details_bloc.dart';
import 'package:detail_dex/screens/user/list_details/list_details.dart';
import 'package:detail_dex/screens/user/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget displayed when there is no network connection.
class NoNetworkWidget extends StatelessWidget {
  const NoNetworkWidget({
    super.key,
    required this.isSplash,
  });
  final bool isSplash;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image(
                width: size.width / 5,
                color: const Color.fromARGB(132, 255, 255, 255),
                image: const AssetImage('assets/images/no-signal.png'),
              ),
            ),
            Text(
              'No network connection !!',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width / 29,
                fontFamily: 'medium',
                fontWeight: FontWeight.normal,
              ),
            ),
            BlocBuilder<DetailsBloc, DetailsState>(
              bloc: homebloc,
              builder: (context, state) {
                bool loading = false;
                if (state is NoNetwoekEventState) {
                  loading = state.istrue;
                }
                return Padding(
                  padding: EdgeInsets.all(size.width / 33),
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: const Color.fromARGB(121, 129, 128, 128),
                      onTap: () async {
                        if (!loading) {
                          homebloc.add(NoNetwoekEvent(istrue: true));
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.none) {
                            await Future.delayed(const Duration(seconds: 1));
                            if (isSplash) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => const SplashScreen(),
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        }
                      },
                      child: Container(
                        height: size.height / 20,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(42, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: loading
                            ? Center(
                                child: SizedBox(
                                  height: size.height / 30,
                                  width: size.width / 14,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Try Again',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width / 33,
                                    fontFamily: 'medium',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
