//
//  CTHelpViewController.swift
//  CreaTECH Help
//
//  Created by Stewart Lynch on 2/14/18.
//  Copyright © 2018 CreaTECH Solutions. All rights reserved.
//

import UIKit
import WebKit
import MessageUI


class CTHelpViewController: UIViewController,UIScrollViewDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ctHelpPageControl: UIPageControl!
    var mailTintColor:UIColor?
    var address:String!
    var ctHelpItem:[CTHelpItem] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        setupScrollView()
        loadCTHelp()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        scrollView.contentSize = CGSize(width: size.width * CGFloat(ctHelpItem.count), height: 315)
        scrollView.contentOffset.x = size.width * CGFloat(ctHelpPageControl.currentPage)
    }
    
     func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(ctHelpItem.count), height: 315)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        ctHelpPageControl.numberOfPages = ctHelpItem.count
        ctHelpPageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
     func loadCTHelp() {
        for (index,ctHelpItem) in ctHelpItem.enumerated() {
            guard let ctHelpView = Bundle.main.loadNibNamed("CTHelp", owner: self, options: nil)?.first as? CTHelpView else {return}
            ctHelpView.delegate = self
            ctHelpView.configureView(ctHelpItem: ctHelpItem)
            scrollView.addSubview(ctHelpView)
            ctHelpView.frame.size.width = self.view.bounds.size.width
            ctHelpView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            ctHelpView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleWidth]
        }
    }
    
     func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func emailDeveloper(withAddress emailAddress:String, withData data:Data?) {
        CTEmailFunctions.emailDeveloper(withAddress:emailAddress, withData: data, mailTintColor: mailTintColor, from: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        ctHelpPageControl.currentPage = Int(page)
    }
    
    @IBAction func moveViewLeftRight(_ sender: UIPageControl) {
        let page = sender.currentPage
        var frame:CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    
}
