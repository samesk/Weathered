//
//  WeatherVC.swift
//  Weathered
//
//  Created by Samuel Eskenasy on 10/07/2017.
//  Copyright © 2017 Samuel Eskenasy. All rights reserved.
//

import Cocoa
import Alamofire


class WeatherVC: NSViewController {
    
    //Outlets
    
    @IBOutlet weak var dateLbl: NSTextField!
    @IBOutlet weak var tempLbl: NSTextField!
    @IBOutlet weak var locationLbl: NSTextField!
    @IBOutlet weak var weatherImage: NSImageView!
    @IBOutlet weak var weatherConditionLbl: NSTextField!
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var poweredByBtn: NSButton!
    @IBOutlet weak var quitBtn: NSButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewDidAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(WeatherVC.dataDownloadedNotif(_:)), name: NOTIF_DOWLOAD_COMPLETE, object: nil)
        self.view.layer?.backgroundColor = CGColor(red: 0.29, green: 0.72, blue: 0.98, alpha: 1.00)
        updateUI()
        quitBtn.styleButtonText(button: quitBtn, buttonName: "Quit", fontColor: .darkGray, alignment: .center, font: "avenir Next", size: 11)
        poweredByBtn.styleButtonText(button: poweredByBtn, buttonName: "Powered By OpenWatherMap", fontColor: .darkGray, alignment: .center, font:"avenir Next", size: 11)
        }
    
    @IBAction func poweredByBtnClick(_ sender: Any) {
        let  url = URL(string: API_HOMEPAGE)!
        NSWorkspace.shared().open(url)
        
    }
    
    @IBAction func quitBtnClick(_ sender: Any) {
        NSApplication.shared().terminate(nil)
    }
        func updateUI() {
            let weather = WeatherService.instance.currentWeather
                dateLbl.stringValue = weather.date
                tempLbl.stringValue = "\(weather.currentTemp)°"
                locationLbl.stringValue = weather.cityName
                weatherConditionLbl.stringValue = weather.weatherType
                weatherImage.image = NSImage(named: weather.weatherType)
                collectionView.reloadData()
        }
    override func viewDidDisappear() {
        NotificationCenter.default.removeObserver(self, name: NOTIF_DOWLOAD_COMPLETE, object: nil)
    }
    
    func dataDownloadedNotif(_ notif: Notification) {
        updateUI()
        print("Notification Upadate UI")
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
extension WeatherVC: NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) ->NSCollectionViewItem {
        
        let forecastItem = collectionView.makeItem(withIdentifier: "WeatherCell", for: indexPath)
        
        
        guard  let forecastCell = forecastItem as? WeatherCell  else
        { return forecastItem }
        forecastCell.configureCell(weatherCell: WeatherService.instance.forecast[indexPath.item])
        
        return forecastCell
        
        
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return WeatherService.instance.forecast.count
    }
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 125, height: 125)
    }

}








