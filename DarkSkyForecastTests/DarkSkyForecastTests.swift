//
//  DarkSkyForecastTests.swift
//  DarkSkyForecastTests
//
//  Created by Alexey on 17/5/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
import Gloss
@testable import DarkSkyForecast

class DarkSkyForecastTests: XCTestCase {
    
    let darkSkyService = DarkSkyService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        testJSONParsing()
        
        XCTAssertNil(darkSkyService.forecast, "Forecast must be nil")
        
        testFetch()
        
        testForecastData(darkSkyService.forecast)
        testCurrentForecastData(darkSkyService.forecast?.currentForecast)
        testDailyForecastData(darkSkyService.forecast?.daily)
        testHourlyForecastData(darkSkyService.forecast?.hourly)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJSONParsing() {
        
        let currentForecastJSON: JSON = [
            "summary": "Rain",
            "temperature": 20.0,
            "time": 1494995454.0,
            "humidity": 0.93,
            "pressure": 1009.55,
            "windSpeed": 9.14,
            "windBearing": 226.0,
            "precipProbability": 0.78
        ]
        
        guard let currentForecast = CurrentForecast(json: currentForecastJSON) else {
            XCTFail("CurrentForecast JSON parsing failed")
            return
        }
        
        testCurrentForecastData(currentForecast)
        
        let dailyForecastJSON: JSON = [
            "summary": "Rain",
            "temperatureMax": 20.0,
            "temperatureMin": 17.5,
            "time": 1494995454.0,
        ]
        
        guard let _ = DailyForecast(json: dailyForecastJSON) else {
            XCTFail("DailyForecast JSON parsing failed")
            return
        }
        
        let hourlyForecastJSON: JSON = [
            "summary": "Rain",
            "temperature": 20.0,
            "time": 1494995454.0,
        ]
        
        guard let _ = HourlyForecast(json: hourlyForecastJSON) else {
            XCTFail("HourlyForecast JSON parsing failed")
            return
        }
        
        let dailyDataForecastJSON: JSON = [
            "data": [dailyForecastJSON]
        ]
        
        let hourlyDataForecastJSON: JSON = [
            "data": [hourlyForecastJSON]
        ]
        
        let forecastJSON: JSON = [
            "currently": currentForecastJSON,
            "daily": dailyDataForecastJSON,
            "hourly": hourlyDataForecastJSON
        ]
        
        guard let forecast = Forecast(json: forecastJSON) else {
            XCTFail("Forecast JSON parsing failed")
            return
        }
        
        testForecastData(forecast)
        testDailyForecastData(forecast.daily)
        testHourlyForecastData(forecast.hourly)
    }
    
    func testFetch() {
        let expect = expectation(description: "downloading forecast data")
        
        darkSkyService.fetch(completion: { (result) in
            switch result {
            case .success:
                XCTAssertFalse(self.darkSkyService.forecast == nil, "Forecast is nil")
                
            case let .failure(error):
                XCTFail("unsuccessful API call: \(error)")
            }
            expect.fulfill()
        })
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testForecastData(_ forecast: Forecast?) {
        XCTAssertFalse(forecast?.currentForecast == nil, "CurrentForecast is nil")
        XCTAssertFalse(forecast?.daily == nil, "Daily data is nil")
        XCTAssertFalse(forecast?.hourly == nil, "Hourly data is nil")
    }
    
    func testCurrentForecastData(_ currentForecast: CurrentForecast?) {
        XCTAssertFalse(currentForecast?.summary == nil, "CurrentForecast.summary is nil")
        XCTAssertFalse(currentForecast?.temperature == nil, "CurrentForecast.temperature is nil")
        XCTAssertFalse(currentForecast?.time == nil, "CurrentForecast.time is nil")
        XCTAssertFalse(currentForecast?.humidity == nil, "CurrentForecast.humidity is nil")
        XCTAssertFalse(currentForecast?.pressure == nil, "CurrentForecast.pressure is nil")
        XCTAssertFalse(currentForecast?.windSpeed == nil, "CurrentForecast.windSpeed is nil")
        XCTAssertFalse(currentForecast?.windBearing == nil, "CurrentForecast.windBearing is nil")
        XCTAssertFalse(currentForecast?.precipProbability == nil, "CurrentForecast.precipProbability is nil")
    }
    
    func testDailyForecastData(_ daily: DailyData?) {
        XCTAssertFalse(daily?.data == nil, "DailyForecast.data is nil")
        XCTAssertFalse(daily?.data?.isEmpty == true, "DailyForecast.data is empty")
        
        for (index, dailyForecast) in daily!.data!.enumerated() {
            XCTAssertFalse(dailyForecast.temperatureMax == nil,
                           "DailyForecast.temperatureMax is nil at index: \(index)")
            XCTAssertFalse(dailyForecast.temperatureMin == nil,
                           "DailyForecast.temperatureMin is nil at index: \(index)")
            XCTAssertFalse(dailyForecast.summary == nil,
                           "DailyForecast.summary is nil at index: \(index)")
            XCTAssertFalse(dailyForecast.time == nil,
                           "DailyForecast.time is nil at index: \(index)")
        }
    }
    
    func testHourlyForecastData(_ hourly: HourlyData?) {
        XCTAssertFalse(hourly?.data == nil, "HourlyForecast.data is nil")
        XCTAssertFalse(hourly?.data?.isEmpty == true, "HourlyForecast.data is empty")
        
        for (index, hourlyForecast) in hourly!.data!.enumerated() {
            XCTAssertFalse(hourlyForecast.temperature == nil,
                           "HourlyForecast.temperature is nil at index: \(index)")
            XCTAssertFalse(hourlyForecast.summary == nil,
                           "HourlyForecast.summary is nil at index: \(index)")
            XCTAssertFalse(hourlyForecast.time == nil,
                           "HourlyForecast.time is nil at index: \(index)")
        }
    }
}
