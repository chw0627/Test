//
//  JsonPlaceHolderViewController.swift
//  Demo
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class JsonPlaceHolderViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var itemId = [String]()
    var itemTitle = [String]()
    var thumbnailUrl = [String]()
    let fullScreenSize:CGSize = UIScreen.main.bounds.size
    let apiURL = "https://jsonplaceholder.typicode.com/photos"
    fileprivate lazy var myCollectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var jsonPlaceHolderURL: URL = {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("jsonPlaceHolder.json")
        } catch {
            fatalError("Error getting hotel URL from document directory.")
        }
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemId.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        cell.idLabel.text = itemId[indexPath.item]
        cell.titleLabel.text = itemTitle[indexPath.item]
        let imageUrl:NSURL = NSURL(string: thumbnailUrl[indexPath.item])!
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell.imageView!.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailPageViewController()
        vc.itemId = itemId[indexPath.item]
        vc.itemTitle = itemTitle[indexPath.item]
        vc.thumbnailUrl = thumbnailUrl[indexPath.item]
        self.navigationController!.pushViewController(vc, animated: true)
    }

    // 下載完成
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("下載完成")
        do {
            let data = try? Data(contentsOf: location)
            try data?.write(to: jsonPlaceHolderURL, options: .atomic)
            print("儲存資訊成功")
            self.jsonParse(jsonPlaceHolderURL)
        } catch {
            print("儲存資訊失敗")
        }
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
            self.removeSpinner()
        }
    }
    
    // 下載過程中
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // 如果 totalBytesExpectedToWrite 一直為 -1
        // 表示遠端主機未提供完整檔案大小資訊
        print("下載進度： \(totalBytesWritten)/\(totalBytesExpectedToWrite)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.showSpinner(onView: self.view)
        self.jsonGet(apiURL)

        let itemSpace: CGFloat = 0
        let columnCount: CGFloat = 4
        let flowLayout = UICollectionViewFlowLayout()
        let width = floor((fullScreenSize.width - itemSpace * (columnCount-1)) / columnCount)
        flowLayout.itemSize = CGSize(width: width, height: width)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumInteritemSpacing = itemSpace
        flowLayout.minimumLineSpacing = itemSpace
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height, width: fullScreenSize.width, height: fullScreenSize.height), collectionViewLayout: flowLayout)
        myCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.bounces = false
        self.view.addSubview(myCollectionView)
    }
    
    func jsonGet(_ myUrl :String) {
        if let url = URL(string: myUrl) {
            // 設置為預設的 session 設定
            let sessionWithConfigure = URLSessionConfiguration.default
            
            // 設置委任對象
            let session = URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: nil)
            
            // 設置遠端 API 網址
            let dataTask = session.downloadTask(with: url)
            
            // 執行動作
            dataTask.resume()
        }
    }
    
    func jsonParse(_ url :URL) {
        do {
            let dict = try JSONSerialization.jsonObject(with: Data(contentsOf: url), options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:AnyObject]]
            let end:Int = dict.count-1
            if end > 0{
                if self.itemId.count > 0{
                    // 清空陣列
                    self.itemId.removeAll()
                    self.itemTitle.removeAll()
                    self.thumbnailUrl.removeAll()
                }
                for i in (0...end){
                    self.itemId.append((dict[i]["id"]?.stringValue)!)
                    self.itemTitle.append(dict[i]["title"] as! String)
                    self.thumbnailUrl.append(dict[i]["thumbnailUrl"] as! String)
                }
            }
            
        } catch {
            print("解析 json 失敗")
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

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
