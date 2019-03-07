//
//  LoadingHud.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/3/7.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

class LoadingHud: NSObject {
    
    static var timerTimes = 0
    static var timer: DispatchSource!
    static var showViews = Array<UIView>()
    
    static func showProgress(supView: UIView){
        
        var loadingImages = [UIImage]()
        for index in 0...14 {
            let loadImageName = String(format: "dyla_img_loading_%03d", index)
            if let loadImage = UIImage(named: loadImageName) {
                loadingImages.append(loadImage)
            }
        }
        
        let timeMilliseconds = 90
        
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        bgView.isHidden = false
        bgView.backgroundColor = UIColor.white
        
        let imgViewFrame = CGRect(x: 0, y: (kScreenH-kScreenW)/2, width: kScreenW, height: kScreenW)
        
        if loadingImages.count > 0 {
            
            if loadingImages.count > timerTimes {
                
                let iv = UIImageView(frame: imgViewFrame)
                iv.image = loadingImages.first!
                iv.contentMode = UIView.ContentMode.scaleAspectFit
                bgView.addSubview(iv)
                
                timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: DispatchQueue.main) as? DispatchSource
                
                timer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.milliseconds(timeMilliseconds))
                
                timer.setEventHandler(handler: { () -> Void in
                    
                    let name = loadingImages[timerTimes % loadingImages.count]
                    
                    iv.image = name
                    
                    timerTimes += 1
                })
                
                timer.resume()
            }
        }

        supView.addSubview(bgView)
        showViews.append(bgView)
        
        bgView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            bgView.alpha = 1
        })
    }
    
    static func clear() {
        self.cancelPreviousPerformRequests(withTarget: self)
        if let _ = timer {
            timer.cancel()
            timer = nil
            timerTimes = 0
        }
        showViews.removeAll()
    }
    
    /// Clear all
    public class func hideHUD() {
        self.cancelPreviousPerformRequests(withTarget: self)
        if let _ = timer {
            timer.cancel()
            timer = nil
            timerTimes = 0
        }
        for (_,view) in showViews.enumerated() {
            view.isHidden = true
        }
    }

}
