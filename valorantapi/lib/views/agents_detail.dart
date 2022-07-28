import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorantapi/constants/dimens.dart';
import 'package:valorantapi/service/agents_model.dart';
import 'package:valorantapi/service/agents_service.dart';
import 'package:valorantapi/views/agents_abilities.dart';

class AgentsDetail extends StatefulWidget {
  int currentIndex;
  AgentsDetail({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<AgentsDetail> createState() => _AgentsDetailState();
}

class _AgentsDetailState extends State<AgentsDetail> {
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
        title: Text(
          _items?[widget.currentIndex].displayName ?? "",
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppDimens.padding15 + 5),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            _items?[widget.currentIndex].displayIcon ?? ""),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(top: AppDimens.padding30),
                  color: Colors.white70,
                  child: Container(
                    padding: EdgeInsets.all(AppDimens.padding15 + 5),
                    width: MediaQuery.of(context).size.width -
                        AppDimens.padding45 +
                        5,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: Text(
                        _items?[widget.currentIndex].description ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontSize: AppDimens.padding30),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppDimens.padding15 + 5,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AgentsAbilities(
                            selectedIndex: widget.currentIndex,
                          );
                        },
                      ));
                    },
                    child: Text(
                      "Yetenekler",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.blueGrey,
                          ),
                    ))
              ],
            )),
    );
  }
}
