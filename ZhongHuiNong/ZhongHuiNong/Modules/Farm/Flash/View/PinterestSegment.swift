//
//  PinterestSegment.swift
//  Demo
//
//  Created by Tbxark on 06/12/2016.
//  Copyright © 2016 Tbxark. All rights reserved.
//

import UIKit

public struct PinterestSegmentStyle {

    public var titleMargin: CGFloat = 15
    public var titlePendingHorizontal: CGFloat = 14
    public var titlePendingVertical: CGFloat = 14
    public var titleFont = UIFont.boldSystemFont(ofSize: 20)
    public var titles: [String] = []
    public var subTitles: [String] = []
    public var isEqual: Bool = false
    public init() {}
}

public class PinterestSegment: UIControl {

    public var style: PinterestSegmentStyle = PinterestSegmentStyle() {
        didSet {
            reloadData()
        }
    }
    
    public var valueChange: ((Int) -> Void)?
    
    fileprivate var titleLabels: [UILabel] = []
    fileprivate var subTitleLabels: [UILabel] = []
    
    public fileprivate(set) var selectIndex = 0


    fileprivate  let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.bounces = true
        view.isPagingEnabled = false
        view.scrollsToTop = false
        view.isScrollEnabled = true
        view.contentInset = UIEdgeInsets.zero
        view.contentOffset = CGPoint.zero
        view.scrollsToTop = false
        return view
    }()

    //MARK:- life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        reloadData()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    @objc fileprivate func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        
        let x = gesture.location(in: self).x + scrollView.contentOffset.x
        
        for (i, label) in titleLabels.enumerated() {
            
            if x >= label.frame.minX && x <= label.frame.maxX {
                setSelectIndex(index: i, animated: true)
                break
            }
        }

    }

}

//MARK: - public helper
extension PinterestSegment {

    public func setSelectIndex(index: Int,animated: Bool = true) {

        guard index != selectIndex, index >= 0 , index < titleLabels.count else { return }

        let nextLab = titleLabels[selectIndex]
        let currentLabel = titleLabels[index]
        let offSetX = min(max(0, currentLabel.center.x - bounds.width / 2),max(0, scrollView.contentSize.width - bounds.width))
        
        print(offSetX)
        print(max(0, currentLabel.center.x - bounds.width / 2))
        print(max(0, scrollView.contentSize.width - bounds.width))
        
        let subTitleLab = subTitleLabels[selectIndex]
        let subCurrentLab = subTitleLabels[index]
        
        nextLab.textColor = UIColor(white: 1, alpha: 0.5)
        nextLab.font = UIFont.boldSystemFont(ofSize: 20)
        currentLabel.textColor = UIColor.white
        currentLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        subTitleLab.textColor = UIColor(white: 1, alpha: 0.5)
        subCurrentLab.textColor = UIColor.white
        
        scrollView.setContentOffset(CGPoint(x:offSetX, y: 0), animated: true)

        selectIndex = index
        valueChange?(index)
        sendActions(for: UIControl.Event.valueChanged)
    }
}



//MARK: - fileprivate helper
extension PinterestSegment {

    fileprivate func reloadData() {

        scrollView.subviews.forEach { $0.removeFromSuperview() }
        titleLabels.removeAll()

        // Set titles
        let font  = style.titleFont
        var titleX: CGFloat = 0.0
        let titleH = font.lineHeight
        let titleW: CGFloat = bounds.width/4
        let titleY: CGFloat = ( bounds.height - font.lineHeight)/2

        scrollView.frame = bounds

        let toToSize: (String) -> CGFloat = { text in
            return (text as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0.0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).width
        }

        for (index, title) in style.titles.enumerated() {

            if style.isEqual {
                titleX = (titleLabels.last?.frame.maxX ?? 0 )
                let rect = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
                let rect1 = CGRect(x: titleX, y: titleY + titleH, width: titleW, height: titleH)
                
                let backLabel = UILabel(frame: CGRect.zero)
                backLabel.tag = index
                backLabel.text = title
                backLabel.textColor = UIColor(white: 1, alpha: 0.5)
                backLabel.font = style.titleFont
                backLabel.textAlignment = .center
                backLabel.frame = rect
                
                titleLabels.append(backLabel)
                scrollView.addSubview(backLabel)
                
                let nextLabel = UILabel(frame: CGRect.zero)
                nextLabel.tag = index
                nextLabel.text = style.subTitles[index]
                nextLabel.textColor = UIColor(white: 1, alpha: 0.5)
                nextLabel.font = style.titleFont
                nextLabel.textAlignment = .center
                nextLabel.frame = rect1
                subTitleLabels.append(nextLabel)
                scrollView.addSubview(nextLabel)
                
                if index == 0 {
                    backLabel.textColor = UIColor.white
                    nextLabel.textColor = UIColor.white
                }
                
                if index == style.titles.count - 1 {
                    scrollView.contentSize.width = rect.maxX
                }
                
            }else {
                
                let title_W = toToSize(title) + style.titlePendingHorizontal * 2
                titleX = (titleLabels.last?.frame.maxX ?? 0 ) + style.titleMargin
                let rect = CGRect(x: titleX, y: titleY, width: title_W, height: titleH)
                
                let backLabel = UILabel(frame: CGRect.zero)
                backLabel.tag = index
                backLabel.text = title
                backLabel.textColor = UIColor(white: 1, alpha: 0.5)
                backLabel.font = style.titleFont
                backLabel.textAlignment = .center
                backLabel.frame = rect
                
                titleLabels.append(backLabel)
                scrollView.addSubview(backLabel)
                
                if index == 0 {
                    backLabel.textColor = UIColor.white
                }
                
                if index == style.titles.count - 1 {
                    scrollView.contentSize.width = rect.maxX + style.titleMargin
                }
            }

        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PinterestSegment.handleTapGesture(_:)))
        addGestureRecognizer(tapGesture)
        setSelectIndex(index: 0)
        
    }
}
