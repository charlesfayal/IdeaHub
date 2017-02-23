//
//  CommentsVC.swift
//  Hatchling
//
//  Created by Steven Graf on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, hasPostVar {
    
    var post:Post!
    var comments:[Comment] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tappedPostBtn(_ sender: Any) {
        let commentContent = commentTextView.text
        let newComment = Comment(content: commentContent!)
        
        DataManager.dm.postComment(comment: newComment, forPost: self.post, withCompletionBlock: {
            (error) in
            if error == nil {
                self.comments.append(newComment)
                self.tableView.reloadData()
                self.dismissKeyboard()
            } else {
                print("Chuck: error posting comment - \(error)")
            }
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Comments viewDidLoad:")
        commentTextView.delegate = self
        DataManager.dm.getComments(forPost: self.post,returnBlock:{
            (returnedComments) in
            print("Chuck: returned Comments")
            self.comments = returnedComments
            self.tableView.reloadData()
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //MARK: Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentTableViewCell") as! CommentTableViewCell
        let comment = comments[indexPath.row]
        cell.commentContentLabel.text = comment.content
        return cell
    }
    
    //MARK: UI functions
    func dismissKeyboard() {
        commentTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textView: UITextView) -> Bool {
        commentTextView.resignFirstResponder()
        return true
    }
    
    // Keyboard shows
    func textViewDidBeginEditing(_ textView: UITextView) {
        moveTextView(textView: textView, moveDistance: -250, up: true)
    }
    
    // Keyboard hidden
    func  textViewDidEndEditing(_ textView: UITextView) {
        moveTextView(textView: textView, moveDistance: -250, up: false)
    }
    //Keyboard movement
    func moveTextView(textView: UITextView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    //move header View
    func moveHeaderView(headerView: UIView, MoveDistance: Int, down: Bool) {
        let MoveDuration = 0.01
        let Movement: CGFloat = CGFloat(down ? MoveDistance : MoveDistance)
        
        UIView.beginAnimations("animateUIView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(MoveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: Movement)
        UIView.commitAnimations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
