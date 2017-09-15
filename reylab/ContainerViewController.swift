//
//  ExempleViewController.swift
//  reylab
//
//  Created by yannick dupire on 15/09/2017.
//  Copyright © 2017 Yannick Dupire. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    @IBAction func pressNextButton(_ sender: Any) {
        if pageViewController?.viewControllers?[0] == pageViewController?.nosViewController.first {
            previousButton.isHidden = false
        }
        pageViewController?.scrollToNextViewController()
        if pageViewController?.viewControllers?[0] == pageViewController?.nosViewController.last {
            nextButton.isHidden = true
        }
        else {
            nextButton.isHidden = false
        }
    }
    
    
    @IBAction func pressPreviousButton(_ sender: Any) {
        pageViewController?.scrollToPreviousViewController()
        if pageViewController?.viewControllers?[0] == pageViewController?.nosViewController.first {
            previousButton.isHidden = true
        }
        else{
            nextButton.isHidden = false
        }
        
    }
    
    
    var pageViewController: PageViewControllerPrincipal? {
        didSet {
            pageViewController?.exempleDelegate = self
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewControllerPrincipal {
            self.pageViewController = pageViewController
        }
    }
}

extension ContainerViewController: protocolPageViewControllerDelegate {
    //Défini le nombre de pages 
    func PageViewController(pageViewController: PageViewControllerPrincipal, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    //défini  le numéro de la page actuelle
    func PageViewController(pageViewController: PageViewControllerPrincipal, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        if pageControl.currentPage >= 1{
            previousButton.isHidden = false
        }
        else {
            previousButton.isHidden = true
        }
        
        if pageControl.currentPage >= pageControl.numberOfPages - 1  {
            nextButton.isHidden = true
        }
        else {
            nextButton.isHidden = false
        }
    }
}

