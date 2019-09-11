//
//  ViewController.swift
//  SimpleOfflineMapBrowser
//
//  Created by Jakub Cali­k on 15/08/2019.
//  Copyright © 2019 Jakub Cali­k. All rights reserved.
//

import UIKit
import SygicMaps
import SygicUIKit
import SygicMapsKit

class ViewController: UIViewController, SYMKModulePresenter {
    
    let sdkKey = ""
    let sdkSecret = ""
    let sdkRouteS = ""
    
    let pathToCustomMaps = Bundle.main.bundlePath + "/customMaps"
    
    var presentedModules = [SYMKModuleViewController]()
    lazy var browseMap: SYMKBrowseMapViewController = {
        let browseMap = SYMKBrowseMapViewController()
        browseMap.useCompass = true
        browseMap.useZoomControl = true
        browseMap.useRecenterButton = true
        browseMap.mapSelectionMode = .all
        browseMap.mapState.zoom = 3
        browseMap.mapState.cameraMovementMode = .followGpsPosition
        return browseMap
    }()
    
    let mapButton: SYUIActionButton = {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.map
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCustomMaps()
        
        SYMKApiKeys.set(appKey: sdkKey, appSecret: sdkSecret, routingKey: sdkRouteS)
        SYMKSdkManager.shared.onlineMapsEnabled = false
        
        browseMap.setupActionButton(with: nil, icon: SYUIIcon.map) {
           self.showManageMapsViewController()
        }
        presentModule(browseMap)
    }
    
    @objc func showManageMapsViewController() {
        present(UINavigationController(rootViewController: ManageMapsViewController()), animated: true, completion: nil)
    }
    
    func loadCustomMaps() {
        let fileManager = FileManager()
        let mapsPaths = try? fileManager.contentsOfDirectory(atPath: pathToCustomMaps)
        let pathToDoc = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
        try? fileManager.createDirectory(at: URL(fileURLWithPath: "\(pathToDoc)/sygic/maps", isDirectory: true), withIntermediateDirectories: true, attributes: [:])
        guard let maps = mapsPaths else { return }
        for map in maps {
            let fromPath = "\(pathToCustomMaps)/\(map)"
            let toPath = "\(pathToDoc)/sygic/maps/\(map)"
            do {
                try fileManager.copyItem(atPath: fromPath, toPath: toPath)
            } catch {
               print(error)
            }
        }
    }
}
