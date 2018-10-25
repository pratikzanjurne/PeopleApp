import UIKit

class JobPostCollectionViewCell: UICollectionViewCell {
    @IBOutlet var jobTitleLbl: UILabel!
    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var workExperienceLbl: UILabel!
    @IBOutlet var salaryLbl: UILabel!
    @IBOutlet var bottomFuncView: UIView!
    
    
    var size:CGSize?
    var indexPath:IndexPath?
    let btnImageArray = [#imageLiteral(resourceName: "Group 2092"),#imageLiteral(resourceName: "Group 358"),#imageLiteral(resourceName: "Group 357"),#imageLiteral(resourceName: "Group 359")]
    var widthAnchorStack:CGFloat = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.jobTitleLbl.sizeToFit()
        self.locationLbl.sizeToFit()
        self.workExperienceLbl.sizeToFit()
        self.salaryLbl.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        widthAnchorStack = CGFloat((btnImageArray.count * 40))
        self.jobTitleLbl.text = nil
        self.locationLbl.text = nil
        self.workExperienceLbl.text = nil
        self.salaryLbl.text = nil
        if let stackView = self.bottomFuncView.viewWithTag(300){
            stackView.removeFromSuperview()
        }
    }
    
    func setupData(post:HiringJobPostDataModel){
        self.getBtnStack { (stackView) in
    

            self.bottomFuncView.addSubview(stackView)
            NSLayoutConstraint.init(item: stackView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: stackView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint.init(item: stackView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: stackView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint.init(item: stackView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: stackView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0).isActive = true
            stackView.widthAnchor.constraint(equalToConstant: widthAnchorStack)
        }
        self.jobTitleLbl.text = post.jobTitle
        self.locationLbl.text = post.locations?[0]
        guard let exp = post.expMax else { 	return }
        self.workExperienceLbl.text = "\(exp) years"
        self.salaryLbl.text = post.salary
    }
    @objc func onBtnPressed(){
        print("Btn pressed.")
        print(self.indexPath?.row)
    }
    
    func getBtnStack(completion:(UIStackView) ->Void){
        let stackView:UIStackView = UIStackView()
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        for i in 0...btnImageArray.count - 1{
            let button = UIButton()
              button.setImage(btnImageArray[i], for: .normal)
            button.heightAnchor.constraint(equalToConstant: self.bottomFuncView.bounds.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            button.addTarget(self, action: #selector(onBtnPressed), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        stackView.tag = 300
        completion(stackView)
    }
}
