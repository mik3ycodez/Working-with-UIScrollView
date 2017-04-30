//
//  ViewController.swift
//  PageTheScroll
//
//  Created by cbeuser on 4/23/17.
//  Copyright © 2017 CBE User. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    var images = [UIImageView]()
    
    
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = .left
        swipeLeft.delegate = self
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = .right
        swipeRight.delegate = self
        view.addGestureRecognizer(swipeRight)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var contentWidth: CGFloat = 0.0
        let scrollWidth = scrollView.frame.size.width
        //        let scrollHeight = scrollView.frame.size.height
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            
            //contentWidth += newX
            contentWidth += scrollWidth * CGFloat(x)
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
            
        }
        
        //        scrollView.backgroundColor = UIColor.purple
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }
    
    func respondToSwipeGesture(_ sender: UIGestureRecognizer) {
        
        
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                print ("Swiped left!")
                if currentPage < MAX_PAGE { moveScrollView(direction: 1) }
                
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right!")
                if currentPage > MIN_PAGE { moveScrollView(direction: -1) }
            default: break
            }
        }
        
    }
    
    func moveScrollView(direction: Int){
        currentPage = currentPage + direction
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print(scrollView.contentOffset)
        
        switch scrollView.contentOffset.x {
        case 0:
            currentPage = 0
        case scrollView.frame.width:
            currentPage = 1
        case scrollView.frame.width * 2:
            currentPage = 2
        default:
            break
        }
    }

}




