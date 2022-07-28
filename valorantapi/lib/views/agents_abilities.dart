import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorantapi/constants/dimens.dart';
import 'package:valorantapi/constants/strings.dart';
import 'package:valorantapi/service/agents_model.dart';
import 'package:valorantapi/service/agents_service.dart';
import 'package:valorantapi/views/agents_detail.dart';

class AgentsAbilities extends StatefulWidget {
  int selectedIndex;
  AgentsAbilities({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<AgentsAbilities> createState() => _AgentsAbilitiesState();
}

class _AgentsAbilitiesState extends State<AgentsAbilities> {
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
            "${_items?[widget.selectedIndex].displayName ?? ""} ${AppStrings.abilities}"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.padding15 + 5),
              itemCount: _items?[widget.selectedIndex].abilities?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(top: AppDimens.padding30),
                  child: ListTile(
                    onTap: () {},
                    contentPadding: EdgeInsets.all(AppDimens.padding30),
                    leading: Image.network(
                      color: Colors.blueGrey,
                      _items?[widget.selectedIndex]
                              .abilities?[index]
                              .displayIcon ??
                          "",
                    ),
                    title: Text(
                      _items?[widget.selectedIndex]
                              .abilities?[index]
                              .displayName ??
                          "",
                      style: Theme.of(context).textTheme.headline6?.copyWith(),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: AppDimens.padding15),
                      child: Text(
                        _items?[widget.selectedIndex]
                                .abilities?[index]
                                .description ??
                            "",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}






// Container(
//                       padding: EdgeInsets.only(top: 40),
//                       height: 200,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         // color: Colors.red,
//                         color: Colors.blueGrey,
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(_items?[widget.selectedIndex]
//                                   .abilities?[index]
//                                   .displayIcon ??
//                               ""),
//                         ),
//                       ),
//                     ),