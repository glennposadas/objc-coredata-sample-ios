//
//  AddContactViewController.m
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

#import "AddContactViewController.h"
#import "FastCDSAmple-Swift.h"

@interface AddContactViewController () <ImagePickerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProfilePhoto;
@property (weak, nonatomic) IBOutlet UITextField *textField_Name;
@property (weak, nonatomic) IBOutlet UITextField *textField_Phone;
@property (weak, nonatomic) IBOutlet UITextField *textField_Email;

@property (strong, nonatomic) IBOutlet ImagePicker *picker;

@end

@implementation AddContactViewController

- (IBAction)selectImageButtonTapped:(id)sender {
    self.picker = [[ImagePicker alloc] initWithPresentationController:self delegate:self];
    [self.picker presentFrom:self.view];
}

- (IBAction)saveButtonTapped:(id)sender {
    NSData *imageData = UIImageJPEGRepresentation(self.imageViewProfilePhoto.image, 0.8);
    [self.navigationController popViewControllerAnimated:YES];
    
    self.contactBlock(imageData,
                      self.textField_Name.text,
                      self.textField_Phone.text,
                      self.textField_Email.text);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didSelectWithImageData:(NSData *)imageData {
    self.imageViewProfilePhoto.image = [UIImage imageWithData:imageData];
}

- (void)didSelectWithVideoData:(NSData *)videoData videoURL:(NSURL *)videoURL {
    
}

- (void)didCancel {
    
}

@end
