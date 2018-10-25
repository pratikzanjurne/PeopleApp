import Foundation
import UIKit

class UIHelper{
 static let shared = UIHelper()
    
    private init(){
    }
    
    func setShadow(_ view:UIView,radius:CGFloat,opacity:Float,color:UIColor){
        
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.masksToBounds = false

        
    }
    func setCornerRadius(_ view :UIView,radius:CGFloat){
        view.layer.cornerRadius = radius
    }
    
    func setGradientLayer( frame :CGRect,startPoint:CGPoint,endPoint:CGPoint,colors:[CGColor],completion:(CAGradientLayer)->Void){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        completion(gradient)
    }
    
    struct buttons {
        var linkedInBtn = UIButton()
        var copyBtn = UIButton()
        var naukariWebBtn = UIButton()
        var laffarj = UIButton()
    }
}
