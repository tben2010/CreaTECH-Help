//
//  SourceInfo.swift
//  CreaTECH Help
//
//  Created by Stewart Lynch on 2019-01-16.
//  Copyright © 2019 Stewart Lynch. All rights reserved.
//

import UIKit

struct CTSourceInfo {
    let iOSVersion:String =  UIDevice.current.systemVersion
    let deviceVersion:String = UIDevice.current.modelName
    let appVersion:String = Bundle.main.appVersion
    let appName:String = Bundle.main.displayName
}
