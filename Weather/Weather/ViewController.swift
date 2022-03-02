//
//  ViewController.swift
//  Weather
//
//  Created by 권찬호 on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var weatherStackView: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func tapFetchWeatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true) // 버튼이 눌리면 키보드가 사라지게 함
        }
    }
    
    // 화면에 표시
    func configureView(weatherInformation: WeatherInformation) {
        self.cityNameLabel.text = weatherInformation.name // 도시이름
        if let weather = weatherInformation.weather.first { // 날씨
            self.weatherDescriptionLabel.text = weather.description // 현재 날씨 정보
        }
        // 섭씨온도
        self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))°C"
        self.minTempLabel.text = "최저: \(Int(weatherInformation.temp.minTemp - 273.15))°C"
        self.maxTempLabel.text = "최고: \(Int(weatherInformation.temp.maxTemp - 273.15))°C"
    }
    
    // 도시를 못찾을 경우 alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // 날씨를 받는 메소드
    func getCurrentWeather(cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=b8647cc9f46e19c01b8eb61cfb1a9c2d") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) {
            [weak self] data, response, error in
            let successRange = (200..<300) // 서버응답상태
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder() // json 데이터 받기
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode){ // statusCode가 200번대인 경우 정상
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return } // WeatherInformation 형식으로 data를 넘김
                // 메인스레드에서 동작시킴
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
            } else { // statusCode가 200이 아닌 경우 에러메시지 출력
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                // 메인스레드에서 alert
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMessage.message)
                }
            }
            
        }.resume()
    }
    
}

