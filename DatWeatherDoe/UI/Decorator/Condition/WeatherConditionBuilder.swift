//
//  WeatherConditionBuilder.swift
//  DatWeatherDoe
//
//  Created by Inder Dhir on 1/11/22.
//  Copyright © 2022 Inder Dhir. All rights reserved.
//

import Foundation

protocol WeatherConditionBuilderType {
    func build() -> WeatherCondition
}

final class WeatherConditionBuilder: WeatherConditionBuilderType {
    private let response: WeatherAPIResponse

    init(response: WeatherAPIResponse) {
        self.response = response
    }

    func build() -> WeatherCondition {
        switch response.weatherConditionCode {
        case 1006, 1009:
            .cloudy
        case 1003:
            response.isDay ? .partlyCloudy : .partlyCloudyNight
        case 1000:
            response.isDay ? .sunny : .clearNight
        case 1030:
            .mist
        case 1135, 1147:
            .fog
        case 1066,
             1114, 1117,
             1210, 1213, 1216, 1219, 1222, 1225, 1237, 1249, 1252, 1255, 1258, 1261, 1264, 1279, 1282:
            .snow
        case 1192, 1195, 1243, 1246, 1276:
            .heavyRain
        case 1069, 1072, 1168, 1171, 1198, 1201, 1204, 1207:
            .freezingRain
        case 1063, 1150, 1153, 1180, 1183, 1186, 1189, 1240:
            response.isDay ? .partlyCloudyRain : .lightRain
        case 1087, 1273:
            .thunderstorm
        default:
            WeatherCondition.getFallback(isDay: response.isDay)
        }
    }
}
