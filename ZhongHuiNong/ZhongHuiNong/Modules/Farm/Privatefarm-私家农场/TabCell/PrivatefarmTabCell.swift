//
//  PrivatefarmTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import SnapKit

class PrivatefarmTabCell: TableViewCell, TabReuseIdentifier {

    let contView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xDCF2F4, alpha: 0.04)
        view.cuttingCorner(radius: 12)
    }
    
    let dotView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0x0BC7D8)
        view.cuttingCorner(radius: 3)
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "水份"
        lab.textColor = UIColor.hexColor(0x7A7A7A)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let totalLab = Label().then { (lab) in
        lab.text = "524"
        lab.textColor = UIColor.hexColor(0x0D0E10)
        lab.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    let unitLab = Label().then { (lab) in
        lab.text = "ppi"
        lab.textColor = UIColor.hexColor(0x606060)
        lab.font = UIFont.systemFont(ofSize: 11)
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.white
        view.cuttingCorner(radius: 2.5)
    }
    
    let progressView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let startLab = Label().then { (lab) in
        lab.text = "0%"
        lab.textColor = UIColor.hexColor(0xBBBBBB)
        lab.font = UIFont.systemFont(ofSize: 10)
    }
    
    let endLab = Label().then { (lab) in
        lab.text = "100%"
        lab.textColor = UIColor.hexColor(0xBBBBBB)
        lab.font = UIFont.systemFont(ofSize: 10)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(dotView)
        contView.addSubview(titleLab)
        contView.addSubview(totalLab)
        contView.addSubview(unitLab)
        contView.addSubview(lineView)
        contView.addSubview(progressView)
        contView.addSubview(startLab)
        contView.addSubview(endLab)
    }
    
    override func updateUI() {
        super.updateUI()
        contView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        }
        
        dotView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(6)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(6)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(dotView).offset(8)
            make.centerY.equalTo(dotView)
        }
        
        unitLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(dotView)
        }
        
        totalLab.snp.makeConstraints { (make) in
            make.right.equalTo(unitLab.snp.left).offset(-5)
            make.centerY.equalTo(dotView)
        }
        
        startLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        endLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenW-44)
            make.height.equalTo(5)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(lineView)
            make.width.equalTo(kScreenW-44)
            make.height.equalTo(5)
        }
    }
    
    /// Property
    
    var shapeLayer: CAShapeLayer?
    var widthConstraint: Constraint?
    
    var model: PrivatefarmCropsModel = PrivatefarmCropsModel() {
        didSet {
            titleLab.text = model.title
            totalLab.text = "\(model.total)"
            unitLab.text = model.unit
            startLab.text = model.start
            endLab.text = "\(model.end)" + model.unit
            dotView.backgroundColor = UIColor.hexColor(model.color)
            contView.backgroundColor = UIColor.hexColor(model.color, alpha: 0.05)
            
            let num = (model.total/model.end)
            
            debugPrints("进度---\(num)")
            
            if shapeLayer == nil {
                let lay = shapeLayer(UIColor.hexColor(model.color), progress: num)
                progressView.layer.addSublayer(lay)
                shapeLayer = lay
            }
        }
    }
    
    
    func shapeLayer(_ stroke: UIColor , progress: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0, y: 2.5))
        path.addLine(to: CGPoint(x: kScreenW-44 , y: 2.5))
        
        let lay = CAShapeLayer()
        lay.lineWidth = 5
        lay.strokeColor = stroke.cgColor
        lay.fillColor = UIColor.clear.cgColor
        lay.strokeEnd = progress
        lay.path = path.cgPath
        lay.lineCap = CAShapeLayerLineCap.round
        
        // 阴影
        lay.shadowColor = stroke.cgColor
        lay.shadowOffset = .zero
        lay.shadowOpacity = 1
        lay.shadowRadius = 3
        lay.masksToBounds = false
        lay.cornerRadius = 2.5
        return lay
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//
//        // shadowCode
//        progressView.layer.shadowColor = UIColor(red: 0.36, green: 0.76, blue: 0.8, alpha: 1).cgColor
//        progressView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        progressView.layer.shadowOpacity = 1
//        progressView.layer.shadowRadius = 5
//        progressView.layer.cornerRadius = 2
    }

}
