import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/fetch_bloc/fetch_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FetchBloc _bloc = FetchBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Welcome, ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            Text(
              "User",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: BlocProvider(
              create: (context) => _bloc,
              child: BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is FetchSuccess) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.user.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                width: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: Color(0xff247881),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${state.user[index].title} ',
                                        style: TextStyle(
                                            color: Color(0xff247881),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "${state.user[index].content}",
                                        style: TextStyle(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                        maxLines: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }

                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocProvider(
              create: (context) => _bloc,
              child: BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is FetchSuccess) {
                      return ListView.builder(
                          itemCount: state.user.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff247881).withOpacity(0.15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            '${state.user[index].image}',
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${state.user[index].title} ',
                                              style: TextStyle(
                                                color: Color(0xff000000),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.user[index].content}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${state.user[index].created}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          });
                    }

                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
