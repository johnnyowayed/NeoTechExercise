//
//  PageTwoViewController.swift
//  NeoTechExercise
//
//  Created by Johnny Owayed on 11/7/20.
//

import UIKit
import GestureRecognizerClosures

class PageTwoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var view_ScrollView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var button_Continue: UIButton!
    @IBOutlet weak var label_Title: UILabel!
    @IBOutlet weak var label_Decription: UITextView!
    
    var array_Data = [OptionModel]()
    var array_OptionView = [OptionView]()
    var portfolio = PortfolioModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Goal Status"
        self.scrollView.delegate = self
        self.setupUI()
        self.fetchData()
    }
    
    private func setupUI() {
        self.button_Continue.isEnabled = false
        self.button_Continue.backgroundColor = .lightGray
        self.button_Continue.layer.cornerRadius = 4
        self.pageControl.currentPageIndicatorTintColor = .blue
        self.pageControl.pageIndicatorTintColor = .lightGray
        
        self.label_Title.text = "Our Recomendations"
        self.label_Title.applySemiBoldFont(ofSize: 18)
        self.label_Decription.text = "In order for you to get back on track and acheive you goal. we recommend following one of these options. Select an option to see its impact on your financial path on the chart."
        self.label_Decription.applyRegularFont(ofSize: 16)
        self.label_Decription.textColor = .gray
        
    }
    
    private func fetchData() {
        ApiCalls.fetchOptions { (results) in
            for result in results {
                self.array_Data.append(OptionModel.init(data: result))
            }
            self.array_OptionView = self.createOptionViewList()
            self.setupSlideScrollView(array_OptionView: self.array_OptionView)
            self.pageControl.numberOfPages = self.array_OptionView.count
            self.pageControl.currentPage = 0
            self.view.bringSubviewToFront(self.pageControl)
        } errorCallback: { (error) in
            
        }
    }
    
    func createOptionViewList() -> [OptionView]{
        
        func unselectedOptionViewTheme(optionView:OptionView ,color:UIColor, backgroundColor:UIColor) {
            optionView.view_Background.backgroundColor = backgroundColor
            optionView.label_Number.textColor = color
            optionView.label_Name.textColor = color
            optionView.label_Deposit.textColor = color
            optionView.label_Descrition.textColor = color
            optionView.label_Selection.textColor = color
            optionView.label_Selection.text = "Select"
        }
        
        for i in 0...self.array_Data.count-1 {
            let optionView = Bundle.main.loadNibNamed("OptionView", owner: self, options: nil)?.first as! OptionView
            optionView.view_Background.layer.borderWidth = 1
            optionView.view_Background.layer.borderColor = UIColor.lightGray.cgColor
            optionView.view_Background.layer.cornerRadius = 10
            optionView.view_Shadow.backgroundColor = .clear
            optionView.view_Shadow.layer.shadowColor = UIColor.black.cgColor
            optionView.view_Shadow.layer.shadowOpacity = 0.3
            optionView.view_Shadow.layer.shadowOffset = .zero
            optionView.view_Shadow.layer.shadowRadius = 10
            optionView.label_Number.applyRegularFont(ofSize: 12)
            optionView.label_Name.applyRegularFont(ofSize: 18)
            optionView.label_Deposit.applyBoldFont(ofSize: 25)
            optionView.label_Descrition.applyRegularFont(ofSize: 12)
            optionView.label_Selection.applySemiBoldFont(ofSize: 18)
            optionView.label_Number.text = "Option " + "\(i+1)"
            optionView.label_Name.text = self.array_Data[i].name
            optionView.label_Deposit.text = "$" + "\(Int(self.array_Data[i].riskScore * 1000))"
            optionView.label_Descrition.text = self.array_Data[i].description
            unselectedOptionViewTheme(optionView: optionView ,color: .black, backgroundColor: .white)
            
            optionView.view_Background.onTap { (_) in
                self.button_Continue.isEnabled = true
                self.button_Continue.backgroundColor = .blue
                for optionView in self.array_OptionView {
                    unselectedOptionViewTheme(optionView: optionView ,color: .black, backgroundColor: .white)
                }
                unselectedOptionViewTheme(optionView: optionView ,color: .white, backgroundColor: .blue)
                optionView.label_Selection.text = "Selected"
            }
            self.array_OptionView.append(optionView)
        }
        return self.array_OptionView
    }
    
    func setupSlideScrollView(array_OptionView : [OptionView]) {
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view_ScrollView.frame.width, height: self.view_ScrollView.frame.height)
        self.scrollView.contentSize = CGSize(width: self.view_ScrollView.frame.width * CGFloat(array_OptionView.count), height: self.view_ScrollView.frame.height)
        self.scrollView.isPagingEnabled = true
        
        for i in 0 ..< array_OptionView.count {
            array_OptionView[i].frame = CGRect(x: self.view_ScrollView.frame.width * CGFloat(i), y: 0, width: self.view_ScrollView.frame.width, height: self.view_ScrollView.frame.height)
            self.scrollView.addSubview(array_OptionView[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "PageThree") as? PageThreeTableViewController else { return }
        vc.portfolio = self.portfolio
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
