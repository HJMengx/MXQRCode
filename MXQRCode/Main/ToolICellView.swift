//
//  ToolICellView.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/26.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit

typealias ClickedAt = (_ index: Int)->Void

let maxNumberOfRow: CGFloat = 4.0

let ToolCellViewHeight : CGFloat = 60 + 2 * ToolItemHeight

class ToolCellView: UIView {
    
    var clicked : ClickedAt!
    
    var items : [ToolItem] = [ToolItem]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initSubivews(numberOfItems: Int, names: [String], imageNames: [String]) {
        self.backgroundColor = UIColor.white
        var countOfRow : CGFloat = maxNumberOfRow
        let countOfCol : CGFloat = CGFloat(ceil(CGFloat(numberOfItems) / countOfRow))
        
        if Int(maxNumberOfRow) > numberOfItems {
            countOfRow = CGFloat(numberOfItems)
        }
        let rowGapBoundary = CGFloat(20)
        let colGapBoundary = CGFloat(20)
        
        let rowGapBetween = (self.bounds.width - rowGapBoundary * 2 - countOfRow * ToolItemWidth) / (countOfRow - 1)
        
        let colGapBetween = self.bounds.height - colGapBoundary * 2 -  countOfCol * ToolItemHeight /
            (countOfCol - 1)
        
        for index in 0..<numberOfItems {
            
            let rowPosition = index % Int(countOfRow)
            let colPosition = Int(index / Int(countOfRow))
            
            var newColBoundary = colGapBoundary
            
            if colPosition == 0 {
                newColBoundary = 10
            }
            
            let x = ToolItemWidth * CGFloat(rowPosition) + CGFloat(rowPosition) * rowGapBetween + rowGapBoundary
            let y = ToolItemHeight * CGFloat(colPosition) + CGFloat(colPosition) * colGapBetween + newColBoundary
            // new Item
            let item = ToolItem.init(frame: CGRect.init(x: x, y: y, width: ToolItemWidth, height: ToolItemHeight))
            self.addSubview(item)
            item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ToolCellView.cellClicked(gesture:))))
            
            item.settingAttributes(imageName: imageNames[index], itemText: names[index])
            self.items.append(item)
        }
    }
    
    func numberOfItems()->Int {
        return self.items.count
    }

    @objc func cellClicked(gesture : UITapGestureRecognizer) {
        guard let clickItem = gesture.view as? ToolItem else {
            return
        }
        if self.clicked != nil {
            self.clicked(self.items.firstIndex(of: clickItem)!)
        }
    }
}
