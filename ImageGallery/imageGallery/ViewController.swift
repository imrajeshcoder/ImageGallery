//
//  ViewController.swift
//  imageGallery
//
//  Created by Vijay on 28/01/21.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var imgImageViewer: UIImageView!
    @IBOutlet weak var btnfavourite: UIButton!
    @IBOutlet weak var btnImageUpload: UIButton!
    
    var imgUploadImageArray = [UIImage]()
    var boolIsFavouritArray = [Bool]()
    var dicImage = [NSDictionary]()
  
    
    //var dog = (name: Str, dangerous: "false")
    var currentImageIndex = 0
    var noOfImage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //btnfavourite.isSelected = false
        imgImageViewer.isUserInteractionEnabled=true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
        
        self.imgImageViewer.addGestureRecognizer(swipeRight)

            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
            self.imgImageViewer.addGestureRecognizer(swipeLeft)
    }

    @IBAction func btnPreviousImageTouch(_ sender: UIButton) {
        fncPreviousImageShow()
    }
    
    @IBAction func btnVavouriteImageTouch(_ sender: UIButton) {
        
        if (boolIsFavouritArray.isEmpty != true)
        {
            btnfavourite.isSelected.toggle()
            var tmpIsFavouritChange = boolIsFavouritArray[currentImageIndex]
            //print(tmpIsFavouritChange)
            tmpIsFavouritChange.toggle()
            boolIsFavouritArray[currentImageIndex] = tmpIsFavouritChange
            print(boolIsFavouritArray)
            
        }
        
    }
   
    @IBAction func btnNextImageTouch(_ sender: UIButton) {
        
        fncNextImageShow()
        
    }
    
    @IBAction func btnUploadImageTouch(_ sender: UIButton) {
        //presentImagePicker()
        self.present(presentImagePicker(), animated: true, completion: nil)
    }
    
    func presentImagePicker() -> UIImagePickerController
    {
        var imageControlar = UIImagePickerController()
        imageControlar.delegate = self
        imageControlar.sourceType = .savedPhotosAlbum
        return imageControlar
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgImageViewer.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
       // print(info[UIImagePickerController.InfoKey.imageURL])
    
        //dic1.append(["image":imgImageViewer.image,"isFav":false])
        
        dicImage.append(["image":imgImageViewer.image,"isFav":false])
    
       //## print( dicImage[0]["isFav"] as! Bool)
        
        imgUploadImageArray.append(imgImageViewer.image!)
        boolIsFavouritArray.append(false)
        currentImageIndex = imgUploadImageArray.count - 1
        funcFavouritButtonImageChange()
        print(currentImageIndex)
        //lblMessageDisplay.text = ""
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func funcFavouritButtonImageChange(){
            if(boolIsFavouritArray[currentImageIndex] == true)
            {
                btnfavourite.isSelected = true
            }
        else
            {
                btnfavourite.isSelected = false
            }
    }
    
    func fncPreviousImageShow()
    {
        if (currentImageIndex > 0 )
        {
            imgImageViewer.image = imgUploadImageArray[currentImageIndex-1]
            currentImageIndex -= 1
            funcFavouritButtonImageChange()
                       
        }
    }
    
    func fncNextImageShow()
    {
        if ( (currentImageIndex == 0 && imgUploadImageArray.count  == 0) != true && (currentImageIndex >= imgUploadImageArray.count - 1) != true )
        {
           imgImageViewer.image = imgUploadImageArray[currentImageIndex+1]
            
            currentImageIndex += 1
            funcFavouritButtonImageChange()
            
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                fncPreviousImageShow()
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
                fncNextImageShow()
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
}

