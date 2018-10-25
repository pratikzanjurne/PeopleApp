import Foundation
import UIKit

extension JobPostCollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return self.jobPosts.count
        }else if section == 1 && isFetchingPosts{
            return 1
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobPostCollectionViewCell", for: indexPath) as! JobPostCollectionViewCell
            UIHelper.shared.setShadow(cell, radius: 4, opacity: 0.5, color: .darkGray)
            cell.indexPath = indexPath
            cell.setupData(post:jobPosts[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionViewCell", for: indexPath) as! LoadingCollectionViewCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightRatio:CGFloat = (150/325)
        let width:CGFloat = self.view.frame.size.width - 40
        return CGSize(width: width, height: heightRatio * width )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == jobPosts.count - 1 && jobPosts.count != jobPosts[jobPosts.count-1].totalJobCount && !isFetchingPosts{
            self.isFetchingPosts = true
            self.collectionView.reloadSections(IndexSet(integer:1))
            guard let next = Constants.next else { return }
            DBManager.init().requestAPIToGet(url: next, parameters: nil, headers: Constants.headers, completion: { (result) in
                guard let dataObjects = result as? [HiringJobPostDataModel] else { return }
                for object in dataObjects{
                    self.jobPosts.append(object)
                    Constants.next = object.next
                    Constants.prev = object.prev
                }
                self.isFetchingPosts = false
                collectionView.reloadData()
            })
        }
    }
}
