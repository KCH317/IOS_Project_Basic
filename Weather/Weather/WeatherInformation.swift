//
//  WeatherInfomation.swift
//  Weather
//
//  Created by 권찬호 on 2022/03/02.
//

import Foundation


// Codable을 사용하면 json과 WeatherInformation 타입을 왔다갔다 가능함
struct WeatherInformation: Codable {
    let weather: [Weather]
    let temp: Temp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name 
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    // CodingKey 프로토콜은 딕셔너리 key가 달라도 매핑되게끔 해줌
    enum  CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
