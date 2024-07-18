import 'package:detail_dex/screens/admin/admin_clientlist/total_clients/total_clents.dart';
import 'package:detail_dex/screens/admin/admin_clientlist/today_clients/today_clientls.dart';
import 'package:detail_dex/screens/admin/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminClientList extends StatefulWidget {
  const AdminClientList({super.key, required this.exicutive});
  final String exicutive;

  @override
  State<AdminClientList> createState() => _AdminClientListState();
}

class _AdminClientListState extends State<AdminClientList>
    with SingleTickerProviderStateMixin {
  AdminBloc adminBloc = AdminBloc();
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Client Lists',
          style: TextStyle(
            fontFamily: 'dex2',
            color: Colors.white,
            fontSize: size.width / 20,
          ),
        ),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size(size.width, size.height / 20),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Total'),
            ],
            onTap: (value) {
              _currentIndex = value;
              adminBloc.add(AdminTabChanger());
            },
            labelStyle: TextStyle(
              fontFamily: 'dex2',
              color: Colors.white,
              fontSize: size.width / 30,
            ),
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.fill,
            automaticIndicatorColorAdjustment: false,
            indicatorColor: Colors.white,
            indicatorWeight: .2,
          ),
        ),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        bloc: adminBloc,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(size.width / 35),
            child: IndexedStack(
              index: _currentIndex,
              children: [
                TodayClients(exixutive: widget.exicutive),
                TotalClients(exixutive: widget.exicutive),
                Container(
                  color: Colors.amber,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
