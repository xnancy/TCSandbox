//
//  MoveScrollExtensionViewController.swift
//  TCSandbox
//
//  Created by Savannah McCoy on 7/16/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit

extension MoveScrollViewController: UIViewControllerPreviewingDelegate {
    
    
    //PEAK
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
     
//        if CGRectContainsPoint(collectionView1.frame, location) {
    
       // print("running1")
       // print(location.x)
       // print(location.y)
        guard let previewVC = storyboard?.instantiateViewControllerWithIdentifier("PreviewVC") as? PreviewViewController
            else{ return nil }
        guard let indexPath = collectionView1?.indexPathForItemAtPoint(location) else { return nil }
        guard let cell1 = collectionView1?.cellForItemAtIndexPath(indexPath) else { return nil }
        previewVC.selectedItem = String(Gifs.sortedRow1[indexPath.row])
        previewVC.preferredContentSize = CGSize(width: 245, height: 200)
        previewingContext.sourceRect = cell1.frame
        return previewVC
//       
//      }else{
//        
//        print("running2")
//        print(location.x)
//        print(location.y)
//        guard let previewVC2 = storyboard?.instantiateViewControllerWithIdentifier("PreviewVC2") as? Preview2ViewController
//            else{ return nil }
//        guard let indexPath2 = collectionView2.indexPathForItemAtPoint(location) else { return nil }
//        guard let cell2 = collectionView2.cellForItemAtIndexPath(indexPath2) else { return nil}
//        previewVC2.selectedItem2 = String(Gifs.row2[indexPath2.row])
//        previewVC2.preferredContentSize = CGSize(width: 245, height: 200)
//        previewingContext.sourceRect = cell2.frame
//        return previewVC2
//      }
    }
    
    //POP
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
