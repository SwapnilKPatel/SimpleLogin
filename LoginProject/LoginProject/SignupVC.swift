//
//  LoginVC.swift
//  BasicProject
//
//  Created by Ravi Chokshi on 25/07/19.
//  Copyright © 2019 Swapnil Patel. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    @IBOutlet weak var nameTextFiled: UITextField!
     @IBOutlet weak var phTextFiled: UITextField!
     @IBOutlet weak var emailTextFiled: UITextField!
     @IBOutlet weak var passwordTextFiled: UITextField!
      var imagePicker: ImagePicker!
     let rest = RestManager()
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
          self.imagePicker = ImagePicker(presentationController: self, delegate: self)
      UITextField.connectFields(fields: [nameTextFiled, phTextFiled,emailTextFiled,passwordTextFiled])
        // Do any additional setup after loading the view.
        //?per_page=24&store=appleyard-flowers&enable_review_photos=true&full_image_urls=true
        let params = ["per_page":"24",
            "store":"appleyard-flowers",
            "enable_review_photos":true,
            "full_image_urls":true] as [String : Any]
        self.makeRequest(url: URL.init(string: "https://api.reviews.co.uk/timeline/photos"),params: params)
    }

    func validateTextFileds() -> String {
        var msg = ""
        
        if nameTextFiled.isEmpty == true{
            msg = "Name can not be blank"
            
        }else if phTextFiled.isValidContact() == false {
            
              msg = "Enter valid ph."
            
        }else if emailTextFiled.isValidEmail() == false{
            
              msg = "Enter valid email"
            
        }else if passwordTextFiled.isValidPassword() == false{
            
            msg = "Password must have at least one uppercase, one digit, one lowercase,8 characters total"
            
        }
        return msg
    }

    @IBAction func signupTapped(_ sender: Any) {
        if validateTextFileds() != "" {
        presentAlertWithTitle(title: "", message: validateTextFileds(), options: "Ok") { (option) in
            print("option: \(option)")
            switch(option) {
            case 0:
                print("option one")
                break
            case 1:
                print("option two")
            default:
                break
            }
        }
        }
    }
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        
         self.imagePicker.present(from: sender)
        
    }
    func uploadProfilePic(imgUrl : URL) {
       // let imageFileURL = Bundle.main.url(forResource: "sampleImage", withExtension: "jpg")
        let imageFileInfo = RestManager.FileInfo(withFileURL: imgUrl, filename: "sampleImage.jpg", name: "uploadedFile", mimetype: "image/jpg")
        
//        rest.httpBodyParameters.add(value: "Hello 😀 !!!", forKey: "greeting")
//        rest.httpBodyParameters.add(value: "AppCoda", forKey: "user")
        
      //  upload(files: [imageFileInfo], toURL: URL(string: "https://api.imgur.com/3/image"))
    }
    func uploadImageNData(url :String, param : [String:String],img : UIImage)
    {
   
        
        rest.uploadImage(with: url, param: param, image: img){ results in
            
            if let error = results.error {
                print(error)
            }
            
            if let data = results.data {
                if let toDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    
                    
                    
                    print(toDictionary)
                }
            }
            
           
        }
        
       
    }
    func upload(files: [RestManager.FileInfo], toURL url: URL?) {
        if let uploadURL = url {
            rest.httpBodyParameters.add(value: "name", forKey: "MyTestFile123321")
            rest.httpBodyParameters.add(value: "description", forKey: "MyTestFile123321")
                                      
            rest.upload(files: files, toURL: uploadURL, withHttpMethod: .post) { (results, failedFilesList) in
                print("HTTP status code:", results.response?.httpStatusCode ?? 0)
                
                if let error = results.error {
                    print(error)
                }
                
                if let data = results.data {
                    if let toDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                        
                      
                        
                        print(toDictionary)
                    }
                }
                
                if let failedFiles = failedFilesList {
                    for file in failedFiles {
                        print(file)
                    }
                }
            }
        }
    }
    
    func makeRequest(url : URL? , params : [String : Any] = [:] )  {
        //
        if let reqUrl = url {
          

            rest.makeRequest(toURL: reqUrl,prams :params, withHttpMethod:.get){ (results) in
                
              if let error = results.error {
                print(error)
            }
            
            if let data = results.data {
                if let toDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    print(toDictionary)
                   self.getdata(data: data)
                }
            }
    
    }
        }
    }
    func getdata (data :Data){
        
        let decoder = JSONDecoder()
        
        
        do {
            
           let timeLine = try decoder.decode(ReviewTimelineModel.self, from: data)
            print(timeLine.timeline.count)
        }catch {
          
            print("e")
        }
    }
}
extension SignupVC: ImagePickerDelegate {
    func didSelect(image: UIImage?, imgUrl: URL?) {
         self.userImage.image = image
        let param = ["name": "MyTestFile123321",
                     "description": "My tutorial test file for MPFD uploads"]
      //  uploadProfilePic(imgUrl: imgUrl!)
        
        uploadImageNData(url: uploadUrl, param: param, img: image!)
    }
    
    
   
}
