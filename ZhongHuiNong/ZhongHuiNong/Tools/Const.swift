//
//  Const.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

public let wid = 1   //  店铺id
public let defaultId = -1
public let kScreenS = UIScreen.main.bounds
public let kScreenW = UIScreen.main.bounds.width
public let kScreenH = UIScreen.main.bounds.height
public let kWindow  = UIApplication.shared.keyWindow!
public let IPhone_X = UIDevice.current.userInterfaceIdiom == .phone && kScreenH >= 812 ? true : false
public let kStaBarH: CGFloat = IPhone_X ? 44.0 : 20.0
public let kNavBarH: CGFloat = IPhone_X ? 88.0 : 64.0
public let kTabBarH: CGFloat = IPhone_X ? 83.0 : 49.0
public let kIndicatorH: CGFloat = IPhone_X ? 34 : 0
public let kBottomViewH: CGFloat = IPhone_X == true ? 56+kIndicatorH : 56
public let defaults = UserDefaults.standard

public let placeHolder =  UIImage().getImageWithColor(color: UIColor.hexColor(0xf3f3f3))

public let linkMan = "18681252035"
public let developmentMan = "18782967728"

typealias BtnAction = ()->()
typealias IndexAction = (Int)->()
