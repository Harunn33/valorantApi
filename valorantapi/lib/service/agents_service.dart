import 'dart:io';

import 'package:dio/dio.dart';
import 'package:valorantapi/service/agents_model.dart';

abstract class IAgentsService {
  Future<List<AgentsModel>?> fetchRelatedAgents();
}

class AgentsService implements IAgentsService {
  final Dio _dio;

  AgentsService()
      : _dio = Dio(BaseOptions(baseUrl: "https://valorant-api.com/v1/"));
  @override
  Future<List<AgentsModel>?> fetchRelatedAgents() async {
    final response = await _dio.get(_AgentsServicePaths.agents.name);
    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data["data"];
      if (_datas is List) {
        return _datas.map((e) => AgentsModel.fromJson(e)).toList();
      }
    }
    return null;
  }
}

enum _AgentsServicePaths { agents }
