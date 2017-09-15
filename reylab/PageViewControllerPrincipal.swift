//
//  ExemplePageViewController.swift
//  reylab
//
//  Created by yannick dupire on 14/09/2017.
//  Copyright © 2017 Yannick Dupire. All rights reserved.
//

import UIKit

class PageViewControllerPrincipal: UIPageViewController {

    
    var exempleDelegate : protocolPageViewControllerDelegate?
    
    private(set) lazy var nosViewController: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page 1"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page 2"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page 3"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page 2")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Apres le chargement de la vue
        
        dataSource = self
        delegate = self
        
        
        scrollToViewController(viewController: nosViewController.first!)
        
        exempleDelegate?.PageViewController(pageViewController: self, didUpdatePageCount: nosViewController.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Aller au viewController suivant
    func scrollToNextViewController(){
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController){
                scrollToViewController(viewController: nextViewController)
        }
    }
    
    //Aller au viewController précédent
    func scrollToPreviousViewController(){
        if let visibleViewController = viewControllers?.last,
            let previousViewController = pageViewController(self, viewControllerBefore: visibleViewController){
                scrollToViewController(viewController: previousViewController)
        }
    }
    
    //Aller au viewController selectionné avec l'animation choisie
    func scrollToViewController(viewController: UIViewController){
        setViewControllers([viewController],
                           direction: .forward,
                           animated: true,
                           completion: {(finished) -> Void in
                                self.mettreAJourIndexExempleDelegate()
        })
    }
    
    func mettreAJourIndexExempleDelegate(){
        if let firstViewController = viewControllers?.first, let index = nosViewController.index(of: firstViewController){
            exempleDelegate?.PageViewController(pageViewController: self, didUpdatePageIndex: index)
        }
    }
    
}

extension PageViewControllerPrincipal: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = nosViewController.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard nosViewController.count > previousIndex else {
            return nil
        }
        
        return nosViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = nosViewController.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let nombreDeViewsControllers = nosViewController.count
        
        guard nombreDeViewsControllers != nextIndex else {
            return nil
        }
        
        guard nombreDeViewsControllers > nextIndex else {
            return nil
        }
        
        return nosViewController[nextIndex]
    }
}

extension PageViewControllerPrincipal: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        mettreAJourIndexExempleDelegate()
    }
}

protocol protocolPageViewControllerDelegate {
    //Fonction appelé automatiquement quand le nombre de page se met à jour. Pour notre exemple, on ajoute pas de page sauf au laucement de l'application
    func PageViewController(pageViewController: PageViewControllerPrincipal, didUpdatePageCount count: Int)
    //Fonction appelé automatiquement quant l'index de page changez
    func PageViewController(pageViewController: PageViewControllerPrincipal, didUpdatePageIndex index: Int)
}
