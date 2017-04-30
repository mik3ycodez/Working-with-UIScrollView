//
//  ViewController.swift
//  PageTheScroll
//
//  Created by cbeuser on 4/23/17.
//  Copyright © 2017 CBE User. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var images = [UIImageView]()
    @IBOutlet weak var scrollView: UIScrollView!
    
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var contentWidth: CGFloat = 0.0
        let scrollWidth = scrollView.frame.size.width
        let scrollHeight = scrollView.frame.size.height
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            contentWidth += scrollWidth * CGFloat(x)
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75, y: (scrollHeight / 2) - 75, width: 150, height: 150)
        }
        
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
        scrollView.delegate = self
    }
    
    func respondToSwipeGesture(_ sender: UIGestureRecognizer) {
        
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left!")
                if currentPage == MIN_PAGE || currentPage < MAX_PAGE { moveScrollView(direction: 1) }
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right!")
                if currentPage == MAX_PAGE || currentPage > MIN_PAGE { moveScrollView(direction: -1) }
            default: break
            }
        }
        
    }
    
    func moveScrollView(direction: Int){
        currentPage = currentPage + direction
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
    }
}
