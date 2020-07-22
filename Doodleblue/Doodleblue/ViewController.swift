//
//  ViewController.swift
//  Doodleblue
//
//  Created by Rahul on 20/07/20.
//  Copyright © 2020 Sri Ram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTblView: UITableView!
       
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var resultTblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var stackVw: UIStackView!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var midLbl: UILabel!
    @IBOutlet weak var bottomLbl: UILabel!
    var btnTag:Int?
    
    var sentenceArray = ["This is the third sentence","This is the second sentence example for having more words when compared to the first one","This is the first sentence example for having more words when compared to the first one"]
    
    var choiceArray = ["1","2","3"]
        
    var choiceTblVw: UITableView!
    
    @IBOutlet weak var resultTblView: UITableView!
    
    var resultsArray:[String] = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTblView.register(UITableViewCell.self, forCellReuseIdentifier: "resultCell")
        
        resultTblView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        tblHeight.constant = mainTblView.contentSize.height
    }
    
    
    @IBAction func didClickChoiceBtn(_ sender: UIButton) {
   
        if resultsArray.contains("") == false
        {
            choiceTblVw.isHidden = true
        }
        else
        {
            btnTag = sender.tag

            if ((btnTag == 1 && topLbl.text != "") || (btnTag == 2 && midLbl.text != "") || (btnTag == 3 && bottomLbl.text != ""))
            {
                choiceTblVw.isHidden = true
            }
            else
            {
            
            if choiceTblVw?.isHidden == false
            {
                choiceTblVw.removeFromSuperview()
            }
            
            var yAxis: CGFloat = 0
            var tblHeight:CGFloat = 0
            
            if sender.tag == 1
            {
                yAxis = self.topView.frame.origin.y
                tblHeight = self.topView.frame.height
            }
            else if sender.tag == 2
            {
                yAxis = self.midView.frame.origin.y
                tblHeight = self.midView.frame.height
            }
            else if sender.tag == 3
            {
                yAxis = self.bottomView.frame.origin.y
                tblHeight = self.bottomView.frame.height
            }
            
            
            
            choiceTblVw = UITableView(frame: CGRect(x: stackVw.frame.origin.x, y: yAxis + tblHeight + 25, width: 50, height: 70))
            choiceTblVw.register(UITableViewCell.self, forCellReuseIdentifier: "choiceCell")
            choiceTblVw.dataSource = self
            choiceTblVw.delegate = self
            
            choiceTblVw.layer.shadowColor = UIColor.lightGray.cgColor
            choiceTblVw.layer.shadowRadius = 5
            choiceTblVw.layer.shadowOpacity = 0.5
            choiceTblVw.layer.shadowOffset = .zero
            choiceTblVw.layer.masksToBounds = false
            
            choiceTblVw.bounces = false
            
            self.view.addSubview(choiceTblVw)
        }
        }
        
        
    }
    
    
    
    @IBAction func didClickClearValues(_ sender: Any) {
        
        topLbl.text = ""
        midLbl.text = ""
        bottomLbl.text = ""
        choiceArray = ["1","2","3"]
        resultsArray = ["","",""]
        
        resultTblView.reloadData()
        resultTblView.layoutIfNeeded()

        resultTblHeight.constant = resultTblView.contentSize.height
        
    }
    


}


//MARK: Table view
extension ViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var rowCount:Int?

        if tableView == mainTblView
        {
            rowCount = sentenceArray.count
        }
        else if tableView == choiceTblVw
        {
            rowCount = choiceArray.count
        }
        else if tableView == resultTblView
        {
            rowCount = resultsArray.count
        }
        
        return rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == mainTblView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
            cell.sentenceLbl.text = sentenceArray[indexPath.row]
            return cell
        }
        else if tableView == choiceTblVw
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "choiceCell", for: indexPath)
            cell.textLabel?.text = "\(choiceArray[indexPath.row])"
            return cell
        }
        else if tableView == resultTblView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
            cell.textLabel?.text = resultsArray[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            return cell
        }
        return UITableViewCell()
               
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        choiceTblVw.removeFromSuperview()
                
        if btnTag == 1
        {
            topLbl.text = "\(choiceArray[indexPath.row])"
            resultsArray.remove(at: indexPath.row)
            resultsArray.insert("\(choiceArray[indexPath.row] + ". " + sentenceArray[0])", at: indexPath.row)
            resultTblView.reloadData()
        }
        else if btnTag == 2
        {
            midLbl.text = "\(choiceArray[indexPath.row])"
            resultsArray.remove(at: indexPath.row)
            resultsArray.insert("\(choiceArray[indexPath.row] + ". " + sentenceArray[1])", at: indexPath.row)
            resultTblView.reloadData()
        }
        else if btnTag == 3
        {
            bottomLbl.text = "\(choiceArray[indexPath.row])"
            resultsArray.remove(at: indexPath.row)
            resultsArray.insert("\(choiceArray[indexPath.row] + ". " + sentenceArray[2])", at: indexPath.row)
            resultTblView.reloadData()
        }
         
        choiceArray.remove(at: indexPath.row)
        choiceArray.insert("", at: indexPath.row)
        
        resultTblView.layoutIfNeeded()

        resultTblHeight.constant = resultTblView.contentSize.height


        print(indexPath.row)
                
        print(resultsArray)
                
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == choiceTblVw
        {
            if choiceArray[indexPath.row] == ""
            {
                return 0
            }
        }
        
        
        return UITableView.automaticDimension
        
    }
    
   
}








