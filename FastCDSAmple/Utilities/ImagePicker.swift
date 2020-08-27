//
//  ImagePicker.swift
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import AVFoundation
import UIKit

typealias ImagePickerCallBack = ((_ selectedImageData: Data?) -> Void)

@objc public protocol ImagePickerDelegate: NSObjectProtocol {
    func didSelect(imageData: Data)
    func didSelect(videoData: Data, videoURL: URL)
    func didCancel()
}

open class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    @objc private weak var delegate: ImagePickerDelegate?
    
    @objc public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    }
    
    class func generateThumbnail(for asset: AVAsset) -> UIImage? {
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMake(value: 1, timescale: 2)
        let image = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        
        if let image = image {
            return UIImage(cgImage: image)
        }
        
        return nil
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    @objc public func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Camera") {
            alertController.addAction(action)
        }
        
        if let action = self.action(for: .photoLibrary, title: "Open from Device") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        self.delegate?.didCancel()
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) {
            if let image = info[.originalImage] as? UIImage,
                let data = image.jpegData(compressionQuality: 0.8) {
                self.delegate?.didSelect(imageData: data)
            }
        }
        
        if let videoURL = info[.mediaURL] as? URL {
            do {
                let videoData = try Data(contentsOf: videoURL, options: .mappedIfSafe)
                self.delegate?.didSelect(videoData: videoData, videoURL: videoURL)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}


