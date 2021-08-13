class DataLoader {
  final data;
  DataLoader(this.data);

  Map<String, int> deviceDataMap = Map();
  Map<String, double> socialMediaDataMap = Map();
  Map<String, int> osDataMap = Map();
  Map<String, int> countryDataMap = Map();
  Map<String, int> browserDataMap = Map();
  Map<String, dynamic> generalDataMap = Map();

  load() {
     loadDeviceData();
    loadOSData();
    loadSocialMediaData();
    loadBrowserData();
    loadcountryData();
    loadGeneralData();
  }

  loadGeneralData() {
    generalDataMap.putIfAbsent('date', () => data['stats']['date']);
    generalDataMap.putIfAbsent('fullLink', () => data['stats']['fullLink']);
    generalDataMap.putIfAbsent('clicks', () => data['stats']['clicks']);
    generalDataMap.putIfAbsent('shortLink', () => data['stats']['shortLink']);
  }

  loadDeviceData() {
    if (data["stats"]["devices"]["dev"] != null) {
      data["stats"]["devices"]["dev"].forEach((key, value) {
        if (value['tag'].contains('Desktop')) {
          if (deviceDataMap.containsKey('Desktop'))
            deviceDataMap.update(
                'Desktop', (click) => click += int.parse(value['clicks']));
          else
            deviceDataMap.putIfAbsent(
                'Desktop', () => int.parse(value['clicks']));
        } else if (value['tag'].contains('Mobile') ||
            value['tag'].contains('Phablet')) {
          if (deviceDataMap.containsKey('Mobile'))
            deviceDataMap.update(
                'Mobile', (click) => click += int.parse(value['clicks']));
          else
            deviceDataMap.putIfAbsent(
                'Mobile', () => int.parse(value['clicks']));
        } else {
          if (deviceDataMap.containsKey('Others'))
            deviceDataMap.update(
                'Others', (click) => click += int.parse(value['clicks']));
          else
            deviceDataMap.putIfAbsent(
                'Others', () => int.parse(value['clicks']));
        }
      });
    }
    print(deviceDataMap);
  }

  loadBrowserData() {
    if (data["stats"]["devices"]["bro"] != null) {
      data["stats"]["devices"]["bro"].forEach((key, value) {
        if (value['tag'].contains('Chrome')) {
          if (browserDataMap.containsKey('Chrome'))
            browserDataMap.update(
                'Chrome', (click) => click += int.parse(value['clicks']));
          else
            browserDataMap.putIfAbsent(
                'Chrome', () => int.parse(value['clicks']));
        } else if (value['tag'].contains('Edge')) {
          if (browserDataMap.containsKey('Edge'))
            browserDataMap.update(
                'Edge', (click) => click += int.parse(value['clicks']));
          else
            browserDataMap.putIfAbsent(
                'Edge', () => int.parse(value['clicks']));
        } else if (value['tag'].contains('Safari')) {
          if (browserDataMap.containsKey('Safari'))
            browserDataMap.update(
                'Safari', (click) => click += int.parse(value['clicks']));
          else
            browserDataMap.putIfAbsent(
                'Safari', () => int.parse(value['clicks']));
        } else if (value['tag'].contains('Opera')) {
          if (browserDataMap.containsKey('Opera'))
            browserDataMap.update(
                'Opera', (click) => click += int.parse(value['clicks']));
          else
            browserDataMap.putIfAbsent(
                'Opera', () => int.parse(value['clicks']));
        } else if (value['tag'].contains('Firefox')) {
          if (browserDataMap.containsKey('Firefox'))
            browserDataMap.update(
                'Firefox', (click) => click += int.parse(value['clicks']));
          else
            browserDataMap.putIfAbsent(
                'Firefox', () => int.parse(value['clicks']));
        } else {
          if (browserDataMap.containsKey('Others'))
            browserDataMap.update(
                'Others', (click) => click += int.parse(value['clicks']));
          else
            browserDataMap.putIfAbsent(
                'Others', () => int.parse(value['clicks']));
        }
      });
    }
    print(browserDataMap);
  }

  loadOSData() {
    if (data["stats"]["devices"]["sys"] != null) {
      data["stats"]["devices"]["sys"].forEach((key, value) {
        if (value['tag'].contains('Windows')) {
          if (osDataMap.containsKey('Windows'))
            osDataMap.update(
                'Windows', (click) => click += int.parse(value['clicks']));
          else
            osDataMap.putIfAbsent('Windows', () => int.parse(value['clicks']));
        } else if (value['tag'].contains('Android')) {
          if (osDataMap.containsKey('Android'))
            osDataMap.update(
                'Android', (click) => click += int.parse(value['clicks']));
          else
            osDataMap.putIfAbsent('Android', () => int.parse(value['clicks']));
        } else if (value['tag'].contains('iOS')) {
          if (osDataMap.containsKey('iOS'))
            osDataMap.update(
                'iOS', (click) => click += int.parse(value['clicks']));
          else
            osDataMap.putIfAbsent('iOS', () => int.parse(value['clicks']));
        } else if (value['tag'].contains('Linux')) {
          if (osDataMap.containsKey('Linux'))
            osDataMap.update(
                'Linux', (click) => click += int.parse(value['clicks']));
          else
            osDataMap.putIfAbsent('Linux', () => int.parse(value['clicks']));
        } else {
          if (osDataMap.containsKey('Others'))
            osDataMap.update(
                'Others', (click) => click += int.parse(value['clicks']));
          else
            osDataMap.putIfAbsent('Others', () => int.parse(value['clicks']));
        }
      });
    }
    print(osDataMap);
  }

  loadcountryData() {
    if (data["stats"]["devices"]["geo"] != null) {
      data["stats"]["devices"]["geo"].forEach((key, value) {
        if (countryDataMap.containsKey(value['tag']))
          countryDataMap.update(
              value['tag'], (click) => click += int.parse(value['clicks']));
        else
          countryDataMap.putIfAbsent(
              value['tag'], () => int.parse(value['clicks']));
      });
    }
    print(countryDataMap);
  }

  loadSocialMediaData() {
    socialMediaDataMap.putIfAbsent(
        'Facebook', () => data["stats"]["facebook"].toDouble());
    socialMediaDataMap.putIfAbsent(
        'Twitter', () => data["stats"]["twitter"].toDouble());
    // socialMediaDataMap.putIfAbsent(
    //     'pinterest', () => data["stats"]["pinterest"].toDouble());
    // socialMediaDataMap.putIfAbsent(
    //     'googlePlus', () => data["stats"]["googlePlus"].toDouble());
    socialMediaDataMap.putIfAbsent(
        'Linkedin', () => data["stats"]["linkedin"].toDouble());
    socialMediaDataMap.putIfAbsent(
        'Others', () => data["stats"]["rest"].toDouble());
    print(socialMediaDataMap);
  }
}
