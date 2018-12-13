//
//  SwipingController.swift
//  My Green House
//
//  Created by Ivan Ignacio Lopez Ambrocio on 2018-12-12.
//  Copyright © 2018 Ivan Ignacio Lopez Ambrocio. All rights reserved.
//

import UIKit


extension UIColor{
    //static var mainGreen = UIColor(red: 112/255, green: 130/255, blue: 56/255, alpha: 1) //Olive
    //static var mainGreen = UIColor(red: 63/255, green: 122/255, blue: 77/255, alpha: 1) //Hunter
    static var mainGreen = UIColor(red: 107/255, green: 177/255, blue: 4/255, alpha: 1) //Olive
}

class SwippingController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    //Pages to show
    let pages = [
        Page(image: "MyGreenHouse", header: "My Green House App", body: "We are more than excited to help you get started in this, your new journey. We will guide you through the process to set up the modules in your <<My Green House>> Additionally you will be able to control not only the lights but implement a full green house"),
        Page(image: "GreenLeaf", header: "Subscribe and get coupons on our daily events", body: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have, so we can help more people using My Green House"),
        Page(image: "GirlWithiPad", header: "Easy setup", body: "Once you setup the App you will be able to manage your My Green House, control independently every station inside of it and receive information related with best practices completely customized for you"),
       
        Page(image: "AppleWatch", header: "Keep connected while you are away", body: "With a full connection, we are proud to announce the new implementation of real time databases, keep connected no matter where you are."),
         Page(image: "FaceId", header: "Security", body: " Advanced Face ID. Security is simple when your face is your password. You can unlock your My Green House, log in to independent stations and pay for add-ons with a glance"),
        Page(image: "Apple3", header: "Don't miss the process", body: "For limited time, you'll be able to install My Green House up to 4 devices, cause we understand no one wants to lose a moment of a newborn"),            
    ]
    
    private lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .mainGreen
        return pc
    }()
    
    //Load code
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls() //Change to next Page
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    fileprivate func setupBottomControls(){
        
        //Control the bottom, control stack view
        let bottomControlStackView = UIStackView(arrangedSubviews: [previousButton,pageControl,nextButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        bottomControlStackView.axis = .horizontal
        
        view.addSubview(bottomControlStackView)
        
        NSLayoutConstraint.activate(
            [
                bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private let previousButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainGreen, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainGreen, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    
    @objc private func handleNext(){
//        print("Trying to move next")
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        //collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    @objc private func handlePrev(){
//        print("Trying to move next")
        let nextIndex = max(0, pageControl.currentPage - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        //collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if  self.pageControl.currentPage == 0{
                self.collectionView?.contentOffset = .zero
            }else{
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in
            
        }
    }
                
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
