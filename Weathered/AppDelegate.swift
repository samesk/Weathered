//
//  AppDelegate.swift
//  Weathered
//
//  Created by Samuel Eskenasy on 10/07/2017.
//  Copyright © 2017 Samuel Eskenasy. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    //Veriables
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
       
        statusItem.button?.title = "--°"
        statusItem.action =  #selector (AppDelegate.displayPopUp(_:))
        let updateWeatherData = Timer.scheduledTimer(timeInterval: 60 * 15, target: self, selector: #selector(AppDelegate.downloadWeatherData), userInfo: nil, repeats: true)
        updateWeatherData.tolerance = 60
        downloadWeatherData()
    }
    func downloadWeatherData() {
    WeatherService.instance.downloadWeatherDetails {
        self.statusItem.button?.title = "\(WeatherService.instance.currentWeather.currentTemp)° C"
        WeatherService.instance.downloadForecast(completed: {
            NotificationCenter.default.post(name: NOTIF_DOWLOAD_COMPLETE, object: nil)
        
    })

    }

}
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    func displayPopUp(_ sender: AnyObject?) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "WeatherVC") as? NSViewController else { return }
        let popoverview = NSPopover()
        popoverview.contentViewController = vc
        popoverview.behavior = .transient
        popoverview.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .minY)
    }

}

