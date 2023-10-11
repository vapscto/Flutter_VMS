class GetGpsLocation {
  Annotations? annotations;
  Bounds? bounds;
  Components? components;
  int? confidence;
  String? formatted;
  Northeast? geometry;

  GetGpsLocation(
      {this.annotations,
      this.bounds,
      this.components,
      this.confidence,
      this.formatted,
      this.geometry});

  GetGpsLocation.fromJson(Map<String, dynamic> json) {
    annotations = json['annotations'] != null
        ? new Annotations.fromJson(json['annotations'])
        : null;
    bounds =
        json['bounds'] != null ? new Bounds.fromJson(json['bounds']) : null;
    components = json['components'] != null
        ? new Components.fromJson(json['components'])
        : null;
    confidence = json['confidence'];
    formatted = json['formatted'];
    geometry = json['geometry'] != null
        ? new Northeast.fromJson(json['geometry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.annotations != null) {
      data['annotations'] = this.annotations!.toJson();
    }
    if (this.bounds != null) {
      data['bounds'] = this.bounds!.toJson();
    }
    if (this.components != null) {
      data['components'] = this.components!.toJson();
    }
    data['confidence'] = this.confidence;
    data['formatted'] = this.formatted;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    return data;
  }
}

class Annotations {
  DMS? dMS;
  String? mGRS;
  String? maidenhead;
  Mercator? mercator;
  OSM? oSM;
  UNM49? uNM49;
  int? callingcode;
  Currency? currency;
  String? flag;
  String? geohash;
  double? qibla;
  Roadinfo? roadinfo;
  Sun? sun;
  Timezone? timezone;
  What3words? what3words;
  String? wikidata;

  Annotations(
      {this.dMS,
      this.mGRS,
      this.maidenhead,
      this.mercator,
      this.oSM,
      this.uNM49,
      this.callingcode,
      this.currency,
      this.flag,
      this.geohash,
      this.qibla,
      this.roadinfo,
      this.sun,
      this.timezone,
      this.what3words,
      this.wikidata});

  Annotations.fromJson(Map<String, dynamic> json) {
    dMS = json['DMS'] != null ? new DMS.fromJson(json['DMS']) : null;
    mGRS = json['MGRS'];
    maidenhead = json['Maidenhead'];
    mercator = json['Mercator'] != null
        ? new Mercator.fromJson(json['Mercator'])
        : null;
    oSM = json['OSM'] != null ? new OSM.fromJson(json['OSM']) : null;
    uNM49 = json['UN_M49'] != null ? new UNM49.fromJson(json['UN_M49']) : null;
    callingcode = json['callingcode'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    flag = json['flag'];
    geohash = json['geohash'];
    qibla = json['qibla'];
    roadinfo = json['roadinfo'] != null
        ? new Roadinfo.fromJson(json['roadinfo'])
        : null;
    sun = json['sun'] != null ? new Sun.fromJson(json['sun']) : null;
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    what3words = json['what3words'] != null
        ? new What3words.fromJson(json['what3words'])
        : null;
    wikidata = json['wikidata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dMS != null) {
      data['DMS'] = this.dMS!.toJson();
    }
    data['MGRS'] = this.mGRS;
    data['Maidenhead'] = this.maidenhead;
    if (this.mercator != null) {
      data['Mercator'] = this.mercator!.toJson();
    }
    if (this.oSM != null) {
      data['OSM'] = this.oSM!.toJson();
    }
    if (this.uNM49 != null) {
      data['UN_M49'] = this.uNM49!.toJson();
    }
    data['callingcode'] = this.callingcode;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    data['flag'] = this.flag;
    data['geohash'] = this.geohash;
    data['qibla'] = this.qibla;
    if (this.roadinfo != null) {
      data['roadinfo'] = this.roadinfo!.toJson();
    }
    if (this.sun != null) {
      data['sun'] = this.sun!.toJson();
    }
    if (this.timezone != null) {
      data['timezone'] = this.timezone!.toJson();
    }
    if (this.what3words != null) {
      data['what3words'] = this.what3words!.toJson();
    }
    data['wikidata'] = this.wikidata;
    return data;
  }
}

class DMS {
  String? lat;
  String? lng;

  DMS({this.lat, this.lng});

  DMS.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Mercator {
  double? x;
  double? y;

  Mercator({this.x, this.y});

  Mercator.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class OSM {
  String? editUrl;
  String? noteUrl;
  String? url;

  OSM({this.editUrl, this.noteUrl, this.url});

  OSM.fromJson(Map<String, dynamic> json) {
    editUrl = json['edit_url'];
    noteUrl = json['note_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['edit_url'] = this.editUrl;
    data['note_url'] = this.noteUrl;
    data['url'] = this.url;
    return data;
  }
}

class UNM49 {
  Regions? regions;
  List<String>? statisticalGroupings;

  UNM49({this.regions, this.statisticalGroupings});

  UNM49.fromJson(Map<String, dynamic> json) {
    regions =
        json['regions'] != null ? new Regions.fromJson(json['regions']) : null;
    statisticalGroupings = json['statistical_groupings'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.regions != null) {
      data['regions'] = this.regions!.toJson();
    }
    data['statistical_groupings'] = this.statisticalGroupings;
    return data;
  }
}

class Regions {
  String? aSIA;
  String? iN;
  String? sOUTHERNASIA;
  String? wORLD;

  Regions({this.aSIA, this.iN, this.sOUTHERNASIA, this.wORLD});

  Regions.fromJson(Map<String, dynamic> json) {
    aSIA = json['ASIA'];
    iN = json['IN'];
    sOUTHERNASIA = json['SOUTHERN_ASIA'];
    wORLD = json['WORLD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ASIA'] = this.aSIA;
    data['IN'] = this.iN;
    data['SOUTHERN_ASIA'] = this.sOUTHERNASIA;
    data['WORLD'] = this.wORLD;
    return data;
  }
}

class Currency {
  List<String>? alternateSymbols;
  String? decimalMark;
  String? htmlEntity;
  String? isoCode;
  String? isoNumeric;
  String? name;
  int? smallestDenomination;
  String? subunit;
  int? subunitToUnit;
  String? symbol;
  int? symbolFirst;
  String? thousandsSeparator;

  Currency(
      {this.alternateSymbols,
      this.decimalMark,
      this.htmlEntity,
      this.isoCode,
      this.isoNumeric,
      this.name,
      this.smallestDenomination,
      this.subunit,
      this.subunitToUnit,
      this.symbol,
      this.symbolFirst,
      this.thousandsSeparator});

  Currency.fromJson(Map<String, dynamic> json) {
    alternateSymbols = json['alternate_symbols'].cast<String>();
    decimalMark = json['decimal_mark'];
    htmlEntity = json['html_entity'];
    isoCode = json['iso_code'];
    isoNumeric = json['iso_numeric'];
    name = json['name'];
    smallestDenomination = json['smallest_denomination'];
    subunit = json['subunit'];
    subunitToUnit = json['subunit_to_unit'];
    symbol = json['symbol'];
    symbolFirst = json['symbol_first'];
    thousandsSeparator = json['thousands_separator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alternate_symbols'] = this.alternateSymbols;
    data['decimal_mark'] = this.decimalMark;
    data['html_entity'] = this.htmlEntity;
    data['iso_code'] = this.isoCode;
    data['iso_numeric'] = this.isoNumeric;
    data['name'] = this.name;
    data['smallest_denomination'] = this.smallestDenomination;
    data['subunit'] = this.subunit;
    data['subunit_to_unit'] = this.subunitToUnit;
    data['symbol'] = this.symbol;
    data['symbol_first'] = this.symbolFirst;
    data['thousands_separator'] = this.thousandsSeparator;
    return data;
  }
}

class Roadinfo {
  String? driveOn;
  String? road;
  String? speedIn;

  Roadinfo({this.driveOn, this.road, this.speedIn});

  Roadinfo.fromJson(Map<String, dynamic> json) {
    driveOn = json['drive_on'];
    road = json['road'];
    speedIn = json['speed_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drive_on'] = this.driveOn;
    data['road'] = this.road;
    data['speed_in'] = this.speedIn;
    return data;
  }
}

class Sun {
  Rise? rise;
  Rise? set;

  Sun({this.rise, this.set});

  Sun.fromJson(Map<String, dynamic> json) {
    rise = json['rise'] != null ? new Rise.fromJson(json['rise']) : null;
    set = json['set'] != null ? new Rise.fromJson(json['set']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rise != null) {
      data['rise'] = this.rise!.toJson();
    }
    if (this.set != null) {
      data['set'] = this.set!.toJson();
    }
    return data;
  }
}

class Rise {
  int? apparent;
  int? astronomical;
  int? civil;
  int? nautical;

  Rise({this.apparent, this.astronomical, this.civil, this.nautical});

  Rise.fromJson(Map<String, dynamic> json) {
    apparent = json['apparent'];
    astronomical = json['astronomical'];
    civil = json['civil'];
    nautical = json['nautical'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apparent'] = this.apparent;
    data['astronomical'] = this.astronomical;
    data['civil'] = this.civil;
    data['nautical'] = this.nautical;
    return data;
  }
}

class Timezone {
  String? name;
  int? nowInDst;
  int? offsetSec;
  String? offsetString;
  String? shortName;

  Timezone(
      {this.name,
      this.nowInDst,
      this.offsetSec,
      this.offsetString,
      this.shortName});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nowInDst = json['now_in_dst'];
    offsetSec = json['offset_sec'];
    offsetString = json['offset_string'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['now_in_dst'] = this.nowInDst;
    data['offset_sec'] = this.offsetSec;
    data['offset_string'] = this.offsetString;
    data['short_name'] = this.shortName;
    return data;
  }
}

class What3words {
  String? words;

  What3words({this.words});

  What3words.fromJson(Map<String, dynamic> json) {
    words = json['words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['words'] = this.words;
    return data;
  }
}

class Bounds {
  Northeast? northeast;
  Northeast? southwest;

  Bounds({this.northeast, this.southwest});

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Northeast.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast!.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest!.toJson();
    }
    return data;
  }
}

class Northeast {
  double? lat;
  double? lng;

  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Components {
  String? iSO31661Alpha2;
  String? iSO31661Alpha3;
  List<String>? iSO31662;
  String? sCategory;
  String? sType;
  String? city;
  String? cityDistrict;
  String? continent;
  String? country;
  String? countryCode;
  String? county;
  String? houseNumber;
  String? postcode;
  String? road;
  String? school;
  String? state;
  String? stateCode;
  String? stateDistrict;
  String? suburb;

  Components(
      {this.iSO31661Alpha2,
      this.iSO31661Alpha3,
      this.iSO31662,
      this.sCategory,
      this.sType,
      this.city,
      this.cityDistrict,
      this.continent,
      this.country,
      this.countryCode,
      this.county,
      this.houseNumber,
      this.postcode,
      this.road,
      this.school,
      this.state,
      this.stateCode,
      this.stateDistrict,
      this.suburb});

  Components.fromJson(Map<String, dynamic> json) {
    iSO31661Alpha2 = json['ISO_3166-1_alpha-2'];
    iSO31661Alpha3 = json['ISO_3166-1_alpha-3'];
    iSO31662 = json['ISO_3166-2'].cast<String>();
    sCategory = json['_category'];
    sType = json['_type'];
    city = json['city'];
    cityDistrict = json['city_district'];
    continent = json['continent'];
    country = json['country'];
    countryCode = json['country_code'];
    county = json['county'];
    houseNumber = json['house_number'];
    postcode = json['postcode'];
    road = json['road'];
    school = json['school'];
    state = json['state'];
    stateCode = json['state_code'];
    stateDistrict = json['state_district'];
    suburb = json['suburb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ISO_3166-1_alpha-2'] = this.iSO31661Alpha2;
    data['ISO_3166-1_alpha-3'] = this.iSO31661Alpha3;
    data['ISO_3166-2'] = this.iSO31662;
    data['_category'] = this.sCategory;
    data['_type'] = this.sType;
    data['city'] = this.city;
    data['city_district'] = this.cityDistrict;
    data['continent'] = this.continent;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['county'] = this.county;
    data['house_number'] = this.houseNumber;
    data['postcode'] = this.postcode;
    data['road'] = this.road;
    data['school'] = this.school;
    data['state'] = this.state;
    data['state_code'] = this.stateCode;
    data['state_district'] = this.stateDistrict;
    data['suburb'] = this.suburb;
    return data;
  }
}
