//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by 권찬호 on 2022/02/23.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
    
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    weak var delegate: DiaryDetailViewDelegate?
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(date: diary.date)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diaryList[row] = diary
    }
    
    private func dateToString(date: Date) -> String{
        let formater = DateFormatter()
        formater.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formater.locale = Locale(identifier: "ko_KR")
        return formater.string(from: date)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
      guard let diary = notification.object as? Diary else { return }
      self.diary = diary
      self.configureView()
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let indexPath = self.indexPath else { return }
        guard let diary = self.diary else { return }
        viewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(editDiaryNotification(_:)),
          name: NSNotification.Name("editDiary"),
          object: nil
        )
        self.navigationController?.pushViewController(viewController, animated: true)
    
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else { return }
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
}
