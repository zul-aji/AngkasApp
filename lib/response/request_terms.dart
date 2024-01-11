class Request {
  final String lang;
  final String currency;
  final int time;
  final String id;
  final String server;
  final String host;
  final int pid;
  final KeyDetails key;
  final Map<String, dynamic> params;
  final int version;
  final String method;
  final ClientDetails client;
  final bool hasMore;

  Request({
    required this.lang,
    required this.currency,
    required this.time,
    required this.id,
    required this.server,
    required this.host,
    required this.pid,
    required this.key,
    required this.params,
    required this.version,
    required this.method,
    required this.client,
    required this.hasMore,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      lang: json['lang'],
      currency: json['currency'],
      time: json['time'],
      id: json['id'],
      server: json['server'],
      host: json['host'],
      pid: json['pid'],
      key: KeyDetails.fromJson(json['key']),
      params: Map<String, dynamic>.from(json['params']),
      version: json['version'],
      method: json['method'],
      client: ClientDetails.fromJson(json['client']),
      hasMore: json['has_more'],
    );
  }
}

class KeyDetails {
  final int id;
  final String apiKey;
  final String type;
  final DateTime expired;
  final DateTime registered;
  final DateTime? upgraded;
  final int limitsByHour;
  final int limitsByMinute;
  final int limitsByMonth;
  final int limitsTotal;

  KeyDetails({
    required this.id,
    required this.apiKey,
    required this.type,
    required this.expired,
    required this.registered,
    required this.upgraded,
    required this.limitsByHour,
    required this.limitsByMinute,
    required this.limitsByMonth,
    required this.limitsTotal,
  });

  factory KeyDetails.fromJson(Map<String, dynamic> json) {
    return KeyDetails(
      id: json['id'],
      apiKey: json['api_key'],
      type: json['type'],
      expired: DateTime.parse(json['expired']),
      registered: DateTime.parse(json['registered']),
      upgraded:
          json['upgraded'] != null ? DateTime.parse(json['upgraded']) : null,
      limitsByHour: json['limits_by_hour'],
      limitsByMinute: json['limits_by_minute'],
      limitsByMonth: json['limits_by_month'],
      limitsTotal: json['limits_total'],
    );
  }
}

class ClientDetails {
  final String ip;
  final GeoDetails geo;
  final ConnectionDetails connection;
  final Map<String, dynamic> device;
  final Map<String, dynamic> agent;
  final KarmaDetails karma;

  ClientDetails({
    required this.ip,
    required this.geo,
    required this.connection,
    required this.device,
    required this.agent,
    required this.karma,
  });

  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      ip: json['ip'],
      geo: GeoDetails.fromJson(json['geo']),
      connection: ConnectionDetails.fromJson(json['connection']),
      device: Map<String, dynamic>.from(json['device']),
      agent: Map<String, dynamic>.from(json['agent']),
      karma: KarmaDetails.fromJson(json['karma']),
    );
  }
}

class GeoDetails {
  final String countryCode;
  final String country;
  final String continent;
  final String city;
  final double lat;
  final double lng;
  final String timezone;

  GeoDetails({
    required this.countryCode,
    required this.country,
    required this.continent,
    required this.city,
    required this.lat,
    required this.lng,
    required this.timezone,
  });

  factory GeoDetails.fromJson(Map<String, dynamic> json) {
    return GeoDetails(
      countryCode: json['country_code'],
      country: json['country'],
      continent: json['continent'],
      city: json['city'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
      timezone: json['timezone'],
    );
  }
}

class ConnectionDetails {
  final String type;
  final int ispCode;
  final String ispName;

  ConnectionDetails({
    required this.type,
    required this.ispCode,
    required this.ispName,
  });

  factory ConnectionDetails.fromJson(Map<String, dynamic> json) {
    return ConnectionDetails(
      type: json['type'],
      ispCode: json['isp_code'],
      ispName: json['isp_name'],
    );
  }
}

class KarmaDetails {
  final bool isBlocked;
  final bool isCrawler;
  final bool isBot;
  final bool isFriend;
  final bool isRegular;

  KarmaDetails({
    required this.isBlocked,
    required this.isCrawler,
    required this.isBot,
    required this.isFriend,
    required this.isRegular,
  });

  factory KarmaDetails.fromJson(Map<String, dynamic> json) {
    return KarmaDetails(
      isBlocked: json['is_blocked'],
      isCrawler: json['is_crawler'],
      isBot: json['is_bot'],
      isFriend: json['is_friend'],
      isRegular: json['is_regular'],
    );
  }
}
