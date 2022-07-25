//
//  ThingsViewController.swift
//  Things
//
//  Created by Satyanarayana Akana on 22/07/22.
//

import UIKit

class ThingsViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var nextBtnOL: UIButton!
    var selectedRows: [Int] = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.setup()
    }
    private func registerNib(){
        let nib = UINib(nibName: "ThingCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "ThingCell")
        self.tblView.separatorStyle = .none
        self.tblView.allowsMultipleSelection = true
    }
    private func setup(){
        self.nextBtnOL.isEnabled = false
    }
    @IBAction func nextBtn(_ sender: UIButton) {
        
    }
}

extension ThingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ThingCell") as! ThingCell
        cell.bgView.backgroundColor = UIColor.orange.withAlphaComponent(1.0 - CGFloat(indexPath.row)/7)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !selectedRows.contains(indexPath.row){
            self.selectedRows.append(indexPath.row)
        }
        print(selectedRows)
        self.nextBtnOL.isEnabled = selectedRows.count >= 3
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = selectedRows.firstIndex(of: indexPath.row){
            selectedRows.remove(at: index)
        }
        print(selectedRows)
    }
}
class LeftTopView: UIView{
    override init(frame: CGRect){
      super.init(frame: frame)
      backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder){
      super.init(coder: aDecoder)
      backgroundColor = UIColor.clear
    }
    override func draw(_ rect: CGRect){
        let path = UIBezierPath()
        let width = self.frame.size.width
        let height = self.frame.size.height
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.88 * width , y: 0.0))
        path.addQuadCurve(to: CGPoint(x: 0.0, y: height*0.92), controlPoint: CGPoint(x: 0.4 * width, y: height*1.18))
        path.close()
        UIColor.orange.set()
        path.fill()
    }
}

class RightBottomView: UIView{
    override init(frame: CGRect){
      super.init(frame: frame)
      backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder){
      super.init(coder: aDecoder)
      backgroundColor = UIColor.clear
    }
    override func draw(_ rect: CGRect){
        let path = UIBezierPath()
        let width = self.frame.size.width
        let height = self.frame.size.height
        path.move(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0.12 * width , y: height))
        path.addQuadCurve(to: CGPoint(x: width, y: height*0.08), controlPoint: CGPoint(x: 0.6 * width, y: height*(-0.18)))
        path.close()
        UIColor.orange.set()
        path.fill()
    }
}

class LeftBottomView: UIView{
    override init(frame: CGRect){
      super.init(frame: frame)
      backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder){
      super.init(coder: aDecoder)
      backgroundColor = UIColor.clear
    }
    override func draw(_ rect: CGRect){
        let path = UIBezierPath()
        let width = self.frame.size.width
        let height = self.frame.size.height
        path.move(to: CGPoint(x: 0.0, y: height*0.2))
        path.addQuadCurve(to: CGPoint(x: width, y: 0.66*height), controlPoint: CGPoint(x: 0.5*width, y: (-0.2)*height))
        path.addLine(to: CGPoint(x: width , y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        UIColor.orange.set()
        path.fill()
    }
}

class CardView : UIView
{
  // init the view with a rectangular frame
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }
  // init the view by deserialisation
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    backgroundColor = UIColor.clear
  }
  /// override the draw(_:) to draw your own view
  ///
  /// Default implementation - `rectangular view`
  ///
  override func draw(_ rect: CGRect)
  {
    // Card view corner radius
    let cardRadius = CGFloat(30)
    // Button slot arc radius
    let buttonSlotRadius = CGFloat(30)
    
    // Card view frame dimensions
    let viewSize = self.bounds.size
    // Effective height of the view
    let effectiveViewHeight = viewSize.height - buttonSlotRadius
    // Get a path to define and traverse
    let path = UIBezierPath()
    // Shift origin to left corner of top straight line
    path.move(to: CGPoint(x: cardRadius, y: 0))
    
    // top line
    path.addLine(to: CGPoint(x: viewSize.width - cardRadius, y: 0))
    // top-right corner arc
    path.addArc(
      withCenter: CGPoint(
        x: viewSize.width - cardRadius,
        y: cardRadius
      ),
      radius: cardRadius,
      startAngle: CGFloat(Double.pi * 3 / 2),
      endAngle: CGFloat(0),
      clockwise: true
    )
    // right line
    path.addLine(
      to: CGPoint(x: viewSize.width, y: effectiveViewHeight)
    )
    
    // bottom-right corner arc
    path.addArc(
      withCenter: CGPoint(
        x: viewSize.width - cardRadius,
        y: effectiveViewHeight - cardRadius
      ),
      radius: cardRadius,
      startAngle: CGFloat(0),
      endAngle: CGFloat(Double.pi / 2),
      clockwise: true
    )
    // right half of bottom line
    path.addLine(
      to: CGPoint(x: viewSize.width / 4 * 3, y: effectiveViewHeight)
    )
    // button-slot right arc
    path.addArc(
      withCenter: CGPoint(
        x: viewSize.width / 4 * 3 - buttonSlotRadius,
        y: effectiveViewHeight
      ),
      radius: buttonSlotRadius,
      startAngle: CGFloat(0),
      endAngle: CGFloat(Double.pi / 2),
      clockwise: true
    )
    
    // button-slot line
    path.addLine(
      to: CGPoint(
        x: viewSize.width / 4 + buttonSlotRadius,
        y: effectiveViewHeight + buttonSlotRadius
      )
    )
    // button left arc
    path.addArc(
      withCenter: CGPoint(
        x: viewSize.width / 4 + buttonSlotRadius,
        y: effectiveViewHeight
      ),
      radius: buttonSlotRadius,
      startAngle: CGFloat(Double.pi / 2),
      endAngle: CGFloat(Double.pi),
      clockwise: true
    )
    // left half of bottom line
    path.addLine(
      to: CGPoint(x: cardRadius, y: effectiveViewHeight)
    )
    // bottom-left corner arc
    path.addArc(
      withCenter: CGPoint(
        x: cardRadius,
        y: effectiveViewHeight - cardRadius
      ),
      radius: cardRadius,
      startAngle: CGFloat(Double.pi / 2),
      endAngle: CGFloat(Double.pi),
      clockwise: true
    )
    // left line
    path.addLine(to: CGPoint(x: 0, y: cardRadius))
    // top-left corner arc
    path.addArc(
      withCenter: CGPoint(x: cardRadius, y: cardRadius),
      radius: cardRadius,
      startAngle: CGFloat(Double.pi),
      endAngle: CGFloat(Double.pi / 2 * 3),
      clockwise: true
    )
    
    // close path join to origin
    path.close()
    // Set the background color of the view
    UIColor.gray.set()
    path.fill()
  }
}
