//
//  MainTableViewController.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/22/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit
import QuickLook

class MainTableViewController: UITableViewController {

    var items = [String]()
    var testArray = [(String, UIImage)]()
    
    var fileURL : URL?
    
    let quickLookController = QLPreviewController()
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items.append("Отчет за январь 2015")
        items.append("Отчет о доходах")
        items.append("Справка допуска к данным")
        items.append("Скан загранпаспорта")
        items.append("Справка")
//        items.append("Медицинская справка")
//        items.append("Водительское удостоверение международного образца")
//        items.append("Свидетельство о браке")
//        items.append("Доверенность для юридического лица")
//        items.append("Отчет")
//        items.append("Инфомрационное письмо")
//        items.append("Инженерная записка")
//        items.append("Тех. док.")
//        items.append("ЧОП")
//        items.append("Справка в бассейн")
        items.append("Крайний")
        
        
        if let first = UIImage(named: "1") {
            testArray.append(("1", first))
        }
        if let second = UIImage(named: "2") {
            testArray.append(("2", second))
        }
        if let third = UIImage(named: "3") {
            testArray.append(("3", third))
        }
        if let foth = UIImage(named: "4") {
            testArray.append(("4", foth))
        }
        if let fifth = UIImage(named: "5") {
            testArray.append(("5", fifth))
        }

        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        quickLookController.dataSource = self
        imagePicker.delegate = self
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! FirstTableViewCell
        cell.configure(with: AttachedDocumentsPresentingState.compose, data: items, images: testArray, previewingDelegate: self)
        return cell
    }
    
    @IBAction func printContentSize(_ sender: Any) {
        tableView.reloadData()
        print("Reloaded")
    }

}

extension MainTableViewController : ImageCollectionViewDelegate, DocumentsCollectionViewDelegate {
    
    internal func deleteImage(at index: Int) {
        testArray.remove(at: index)
        if testArray.isEmpty {
            tableView.reloadData()
        }
    }
    
    func preview(image : (String, UIImage)) {
        
        if let fileURL = Bundle.main.url(forResource: image.0, withExtension: "png") {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                self.fileURL = fileURL
                if QLPreviewController.canPreview(fileURL as NSURL) {
                    quickLookController.currentPreviewItemIndex = 0
                    quickLookController.refreshCurrentPreviewItem()
                    navigationController?.pushViewController(quickLookController, animated: true)
                }
            }
        }
    }
    
    func previewDocument(item: String) {
        if let fileURL = Bundle.main.url(forResource: "guide_id_2014", withExtension: "pdf") {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                self.fileURL = fileURL
                if QLPreviewController.canPreview(fileURL as NSURL) {
                    quickLookController.currentPreviewItemIndex = 0
                    quickLookController.refreshCurrentPreviewItem()
                    navigationController?.pushViewController(quickLookController, animated: true)
                }
            }
        }
    }
    
    func showDocumentAddingOptions() {
        let actionSheetController = UIAlertController(title: "Добавить", message: nil, preferredStyle: .actionSheet)
        
        let addPhotoAction = UIAlertAction(title: "Снимок", style: .default) { [weak self] (_) in
            guard let strongSelf = self else { return }
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                strongSelf.presentedViewController?.dismiss(animated: false, completion: nil)
                
                strongSelf.imagePicker.allowsEditing = true
                strongSelf.imagePicker.sourceType = .camera
                strongSelf.imagePicker.cameraCaptureMode = .photo
                strongSelf.imagePicker.modalPresentationStyle = .fullScreen
                
                strongSelf.present(strongSelf.imagePicker, animated: true, completion: nil)
            }
        }
        
        let addImageAction = UIAlertAction(title: "Изображение", style: .default) { [weak self] (_) in
            guard let strongSelf = self else { return }
            
            strongSelf.presentedViewController?.dismiss(animated: false, completion: nil)
            
            strongSelf.imagePicker.allowsEditing = true
            strongSelf.imagePicker.sourceType = .photoLibrary
            
            strongSelf.present(strongSelf.imagePicker, animated: true, completion: nil)
        }
        
        let addDocumentAction = UIAlertAction(title: "Документ", style: .default) { [weak self] (_) in
            guard let strongSelf = self else { return }
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.content"], in: UIDocumentPickerMode.import)
            documentPicker.modalPresentationStyle = .formSheet
            documentPicker.delegate = self
            strongSelf.present(documentPicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { [weak self] (_) in
            self?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
        
        actionSheetController.addAction(addPhotoAction)
        actionSheetController.addAction(addImageAction)
        actionSheetController.addAction(addDocumentAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
}

extension MainTableViewController : QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileURL != nil ? 1 : 0
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let fileURL = fileURL else { return NSURL(fileURLWithPath: "") }
        return fileURL as NSURL
    }
    
}

extension MainTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            testArray.append(("custom",image))
            self.tableView.reloadData()
        }
        // This point could be used to create a sctruct with photo and attach name and JPG type which is default
        dismiss(animated: true, completion: nil)
    }
    
}

extension MainTableViewController : UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let filename = url.deletingPathExtension().lastPathComponent
        let pathExtension = url.pathExtension
        print(filename)
        print(pathExtension)
    }
    
}
