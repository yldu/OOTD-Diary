//
//  ViewController.m
//  OOTD diary
//
//  Created by Shirley Du on 2014-10-28.
//  Copyright (c) 2014 Shirley Du. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface ViewController ()

@property (nonatomic, strong) UIImage *chosenImage;
@property (nonatomic, strong) NSMutableArray *myImages;
@property (nonatomic, strong) CollectionViewController *collectionViewController;
//@property (nonatomic, strong) CHTCollectionViewWaterfallLayout *layout;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation ViewController {
}

- (id) init
{
    self = [super initWithNibName:@"ViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    //self.layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewController = [[CollectionViewController alloc] initWithCollectionViewLayout:self.layout];
    self.myImages = [[NSMutableArray alloc]init];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //[self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    /*
    [self.view addSubview:self.collectionView];
    self.imageView.image = self.chosenImage;
     */
        
}

#pragma  mark - choose photo
- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    //CollectionViewController *cc = [[CollectionViewController alloc] initWithCollectionViewLayout:layout];
    [self presentViewController:picker animated:YES completion:NULL];
}


// TODO:
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"did finish picking media");
    
    
    self.chosenImage = info[UIImagePickerControllerEditedImage];
    [self.myImages addObject:self.chosenImage];
    [self.collectionViewController setCapturedImages: self.myImages];
    self.imageView.image = self.chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self presentViewController:self.collectionViewController animated:YES completion:NULL];
    //[self flipToView];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


/*
- (IBAction)flipToView
{
    NSLog(@"flip to view");
    CollectionViewController *vc = [[CollectionViewController alloc] init];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.transitionController transitionToViewController:vc withOptions:UIViewAnimationOptionTransitionFlipFromRight];
}
 */


@end