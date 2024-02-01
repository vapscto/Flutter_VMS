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
        ? Annotations.fromJson(json['annotations'])
        : null;
    bounds = json['bounds'] != null ? Bounds.fromJson(json['bounds']) : null;
    components = json['components'] != null
        ? Components.fromJson(json['components'])
        : null;
    confidence = json['confidence'];
    formatted = json['formatted'];
    geometry =
        json['geometry'] != null ? Northeast.fromJson(json['geometry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (annotations != null) {
      data['annotations'] = annotations!.toJson();
    }
    if (bounds != null) {
      data['bounds'] = bounds!.toJson();
    }
    if (components != null) {
      data['components'] = components!.toJson();
    }
    data['confidence'] = confidence;
    data['formatted'] = formatted;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
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
    dMS = json['DMS'] != null ? DMS.fromJson(json['DMS']) : null;
    mGRS = json['MGRS'];
    maidenhead = json['Maidenhead'];
    mercator =
        json['Mercator'] != null ? Mercator.fromJson(json['Mercator']) : null;
    oSM = json['OSM'] != null ? OSM.fromJson(json['OSM']) : null;
    uNM49 = json['UN_M49'] != null ? UNM49.fromJson(json['UN_M49']) : null;
    callingcode = json['callingcode'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    flag = json['flag'];
    geohash = json['geohash'];
    qibla = json['qibla'];
    roadinfo =
        json['roadinfo'] != null ? Roadinfo.fromJson(json['roadinfo']) : null;
    sun = json['sun'] != null ? Sun.fromJson(json['sun']) : null;
    timezone =
        json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
    what3words = json['what3words'] != null
        ? What3words.fromJson(json['what3words'])
        : null;
    wikidata = json['wikidata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dMS != null) {
      data['DMS'] = dMS!.toJson();
    }
    data['MGRS'] = mGRS;
    data['Maidenhead'] = maidenhead;
    if (mercator != null) {
      data['Mercator'] = mercator!.toJson();
    }
    if (oSM != null) {
      data['OSM'] = oSM!.toJson();
    }
    if (uNM49 != null) {
      data['UN_M49'] = uNM49!.toJson();
    }
    data['callingcode'] = callingcode;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    data['flag'] = flag;
    data['geohash'] = geohash;
    data['qibla'] = qibla;
    if (roadinfo != null) {
      data['roadinfo'] = roadinfo!.toJson();
    }
    if (sun != null) {
      data['sun'] = sun!.toJson();
    }
    if (timezone != null) {
      data['timezone'] = timezone!.toJson();
    }
    if (what3words != null) {
      data['what3words'] = what3words!.toJson();
    }
    data['wikidata'] = wikidata;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['edit_url'] = editUrl;
    data['note_url'] = noteUrl;
    data['url'] = url;
    return data;
  }
}

class UNM49 {
  Regions? regions;
  List<String>? statisticalGroupings;

  UNM49({this.regions, this.statisticalGroupings});

  UNM49.fromJson(Map<String, dynamic> json) {
    regions =
        json['regions'] != null ? Regions.fromJson(json['regions']) : null;
    statisticalGroupings = json['statistical_groupings'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (regions != null) {
      data['regions'] = regions!.toJson();
    }
    data['statistical_groupings'] = statisticalGroupings;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ASIA'] = aSIA;
    data['IN'] = iN;
    data['SOUTHERN_ASIA'] = sOUTHERNASIA;
    data['WORLD'] = wORLD;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alternate_symbols'] = alternateSymbols;
    data['decimal_mark'] = decimalMark;
    data['html_entity'] = htmlEntity;
    data['iso_code'] = isoCode;
    data['iso_numeric'] = isoNumeric;
    data['name'] = name;
    data['smallest_denomination'] = smallestDenomination;
    data['subunit'] = subunit;
    data['subunit_to_unit'] = subunitToUnit;
    data['symbol'] = symbol;
    data['symbol_first'] = symbolFirst;
    data['thousands_separator'] = thousandsSeparator;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['drive_on'] = driveOn;
    data['road'] = road;
    data['speed_in'] = speedIn;
    return data;
  }
}

class Sun {
  Rise? rise;
  Rise? set;

  Sun({this.rise, this.set});

  Sun.fromJson(Map<String, dynamic> json) {
    rise = json['rise'] != null ? Rise.fromJson(json['rise']) : null;
    set = json['set'] != null ? Rise.fromJson(json['set']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rise != null) {
      data['rise'] = rise!.toJson();
    }
    if (set != null) {
      data['set'] = set!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apparent'] = apparent;
    data['astronomical'] = astronomical;
    data['civil'] = civil;
    data['nautical'] = nautical;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['now_in_dst'] = nowInDst;
    data['offset_sec'] = offsetSec;
    data['offset_string'] = offsetString;
    data['short_name'] = shortName;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['words'] = words;
    return data;
  }
}

class Bounds {
  Northeast? northeast;
  Northeast? southwest;

  Bounds({this.northeast, this.southwest});

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? Northeast.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ISO_3166-1_alpha-2'] = iSO31661Alpha2;
    data['ISO_3166-1_alpha-3'] = iSO31661Alpha3;
    data['ISO_3166-2'] = iSO31662;
    data['_category'] = sCategory;
    data['_type'] = sType;
    data['city'] = city;
    data['city_district'] = cityDistrict;
    data['continent'] = continent;
    data['country'] = country;
    data['country_code'] = countryCode;
    data['county'] = county;
    data['house_number'] = houseNumber;
    data['postcode'] = postcode;
    data['road'] = road;
    data['school'] = school;
    data['state'] = state;
    data['state_code'] = stateCode;
    data['state_district'] = stateDistrict;
    data['suburb'] = suburb;
    return data;
  }
}
