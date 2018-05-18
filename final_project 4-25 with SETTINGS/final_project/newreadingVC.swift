//
//  newreadingVC.swift
//  final_project
//
//  Created by Akshata Sastry on 3/22/17.
//  Copyright © 2017 Akshata Sastry. All rights reserved.
//

import UIKit
import CoreData
import CoreGraphics
import CoreImage

class newreadingVC: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    var createloginVC: createloginVC?
    
    @IBOutlet weak var outputLabel: UILabel!
  /*
    fileprivate func savePerson(result: Int16) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Set the attribute values
        person.setValue(result, forKey: "result")
    
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Add the new entity to our array of managed objects
        people.append(person)
        
    }

    
    @IBAction func submit(_ sender: Any) {
        result = 5
    }
    */
    
    @IBOutlet weak var chosenImage: UIImageView!

    @IBAction func openGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /*
    @IBAction func openCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
 */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    //func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            chosenImage.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveImage(_ sender: Any) {
        if chosenImage.image == nil {
            return
        }
        else {
        
        var imageData = UIImageJPEGRepresentation(chosenImage.image!, 0.6)
        var compressedJPGImage = UIImage(data: imageData!)
        var currentImgCG = compressedJPGImage?.cgImage
            
        // 375 x 667 
        //x: 25 to 100, 150 to 225, 275 to 350
        //y: 74 to 148, 296 to 370, 518 to 592
        //white:(25,222) to (100,444)
        //blue: (150,222) to (225,444)
        //purple: (275,222) to (350,444)
        //FALSE ABOVE^^^
            
        //(2294.0, 1052.0)
            
        var rW:Int = 0
        var gW:Int = 0
        var bW:Int = 0
            
        var rB:Int = 0
        var gB:Int = 0
        var bB:Int = 0
            
        var rP:Int = 0
        var gP:Int = 0
        var bP:Int = 0
            
        //USE SIZE FOR CROPPING!!!!
        print("height: ", compressedJPGImage?.size.height)
        print("width:" , compressedJPGImage?.size.width)
            
        var numPixels:Int = Int((((compressedJPGImage?.size.height)!)/18) * (((compressedJPGImage?.size.width)!)/18))
            
        //print(compressedJPGImage?.getPixelColor(pos: CGPoint(x: 1000,y :1000)).rgb()?.red)
        //print(compressedJPGImage?.getPixelColor(pos: CGPoint(x: 1000,y :1000)).rgb()?.green)
        //print(compressedJPGImage?.getPixelColor(pos: CGPoint(x: 1000,y :1000)).rgb()?.blue)
            
        //white pixel square
        for i in stride(from:(compressedJPGImage?.size.width)!/12,through:(3 * (compressedJPGImage?.size.width)!)/12,by:3){
            for j in stride(from:(compressedJPGImage?.size.height)!/12,through:(3 * (compressedJPGImage?.size.height)!)/12,by:3){
                rW = rW + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.red)!
                gW = gW + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.green)!
                bW = bW + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.blue)!
            }
        }
        
        let whiteVals:[Double] = [Double(rW/numPixels) + 1, Double(gW/numPixels) + 1, Double(bW/numPixels) + 1]
        print(whiteVals)
            
        //blue pixel square
        for i in stride(from:(5 * (compressedJPGImage?.size.width)!)/12,through:(7 * (compressedJPGImage?.size.width)!)/12,by:3){
            for j in stride(from:(5 * (compressedJPGImage?.size.height)!)/12,through:(7 * (compressedJPGImage?.size.height)!)/12,by:3){
                rB = rB + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.red)!
                gB = gB + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.green)!
                bB = bB + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.blue)!
                
            }
        }
            
        let blueRGBVals:[Double] = [Double(rB/numPixels) + 1, Double(gB/numPixels) + 1, Double(bB/numPixels) + 1]
        print(blueRGBVals)
            
        //purple pixel square
        for i in stride(from:(9 * (compressedJPGImage?.size.width)!)/12,through:(11 * (compressedJPGImage?.size.width)!)/12,by:3){
            for j in stride(from:(9 * (compressedJPGImage?.size.height)!)/12,through:(11 * (compressedJPGImage?.size.height)!)/12,by:3){
                rP = rP + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.red)!
                gP = gP + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.green)!
                bP = bP + (compressedJPGImage?.getPixelColor(pos: CGPoint(x: i,y :j)).rgb()?.blue)!
                
            }
        }
        
        let purpleRGBVals:[Double] = [Double(rP/numPixels) + 1, Double(gP/numPixels) + 1, Double(bP/numPixels) + 1]
        print(purpleRGBVals)
    
            
        //print(calibrateCurve(blueRGBVals: blueRGBVals, purpleRGBVals: purpleRGBVals, whiteVals: whiteVals))
        
        let outputS:String = String(round(100 * calibrateCurve(blueRGBVals: blueRGBVals, purpleRGBVals: purpleRGBVals, whiteVals: whiteVals))/100)
        
        outputLabel.text = "Glucose Level: " + outputS
    
        
        //TEST CONVERSION BELOW
        //UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        /*
        var width:Int = currentImgCG!.width
        
        var height:Int = currentImgCG!.height
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and
        // alpha.
        let bitmapBytesPerRow = width * 4
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
        // per component. Regardless of what the source image format is
        // (CMYK, Grayscale, and so on) it will be converted over to the format
        // specified here by CGBitmapContextCreate.
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        // draw the image onto the context
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        //context = draw(_:in:))
        //context.draw(currentImgCG, in: CGRect(origin: .zero, size: currentImgCG.size))
        color_at(context: context, width: width, height: height, x: 50, y: 50)
         */
        
        var alert = UIAlertView(title: "Saved",
                                message: "Your image has been saved!",
                                delegate: nil,
                                cancelButtonTitle: "Ok")
        alert.show()
            
        }
        
    }
    
    /*
    func color_at(context: CGContext, width:Int, height:Int, x: Int, y: Int)->(Int, Int, Int, Int) {
        
        assert(0<=x && x<width)
        assert(0<=y && y<height)
        
        let data = context.data
        //let uncasted_data = context.data
        //let data = UnsafeMutableRawPointer?<UInt8>(uncasted_data)
        
        let offset = 4 * (y * width + x)
        
        //let alpha = data?[offset]
        //let red = data[offset+1]
        //let green = data[offset+2]
        //let blue = data[offset+3]
        
        let color = (Int(red), Int(green), Int(blue), Int(alpha))
        return color
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()



        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = SettingsService.sharedService.backgroundColor;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
