import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorantapi/constants/dimens.dart';
import 'package:valorantapi/constants/strings.dart';
import 'package:valorantapi/service/agents_model.dart';
import 'package:valorantapi/service/agents_service.dart';
import 'package:valorantapi/views/agents_abilities.dart';
import 'package:valorantapi/views/agents_detail.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AgentsModel>? _items;
  late final Dio _dio;
  final _baseUrl = "https://valorant-api.com/v1/";
  bool _isLoading = false;

  late final IAgentsService _agentsService;

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _agentsService = AgentsService();
    fetchAgentsItems();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchAgentsItems() async {
    _changeLoading();
    _items = await _agentsService.fetchRelatedAgents();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppStrings.homeTitle}"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.padding15 + 5),
              itemCount: _items?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(top: AppDimens.padding30),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AgentsDetail(
                            currentIndex: index,
                          );
                        },
                      ));
                    },
                    contentPadding: EdgeInsets.all(AppDimens.padding30),
                    leading: Image.network(
                      _items?[index].displayIcon ?? "",
                    ),
                    title: Text(
                      _items?[index].displayName ?? "",
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(_items?[index].developerName ?? ""),
                  ),
                );
              },
            ),
    );
  }
}
