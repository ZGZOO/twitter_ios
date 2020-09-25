//
//  TweetViewController.swift
//  Twitter
//
//  Created by Zhijie (Jenny) Xu on 9/19/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var wordCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //keyboard shows up, cursor there, just let the user know
        tweetTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
        tweetTextView.delegate = self
        
    }
    
    // WORD COUNT
    // live, get the word count in text view
    // live, 280 - word count
    // live, reflect in wordCountLabel
//    let wordsLeft = 280 - self.tweetTextView
//    if(wordsLeft > 0){
//        wordCountLabel.text = textView.text.count + "words remaining"
//    }else{
//        wordCountLabel.text = textView.text.count + "word remaining"
//    }
    
//    func textViewDidBeginEditing(_ textView: UITextView){
//        print("count: \(textView.text.count)")
//    }
    
//    func textViewDidChange(_ textView: UITextView){
//        print("change,count: \(textView.text.count)")
//        wordCountLabel.text = textView.text.count as! String + " words remaining"
//    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        
        // Set the max character limit
        let characterLimit = 280
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        wordCountLabel.text = String(280 - newText.count) + " characters left"
        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print("Error posting tweet \(Error)")
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
