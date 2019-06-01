//
//  GlobeViewController.m
//  TYSceneDemo
//
//  Created by 田宇 on 2019/6/1.
//  Copyright © 2019 田宇. All rights reserved.
//

#import "GlobeViewController.h"
#import <SceneKit/SceneKit.h>
#import "GlobeScene.h"


@interface GlobeViewController ()

@property(nonatomic, strong) SCNView *sceneView;

@end

@implementation GlobeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCNView *sceneView = [[SCNView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:sceneView];
    self.sceneView = sceneView;
    
    GlobeScene *scene = [[GlobeScene alloc] init];
    self.sceneView.scene = scene;
    self.sceneView.allowsCameraControl = YES;
    self.sceneView.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    NSMutableArray *tapArr = [NSMutableArray array];
    [tapArr addObject:tap];
    [tapArr addObjectsFromArray:self.sceneView.gestureRecognizers];
    self.sceneView.gestureRecognizers = tapArr;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    CGPoint p = [tap locationInView:self.sceneView];
    
    NSArray *hitResults = [self.sceneView hitTest:p options:nil];
    
    if (hitResults.count > 0) {
        SCNHitTestResult *result = [hitResults firstObject];
        NSArray<SCNMaterial *> * materials = result.node.geometry.materials;
        SCNMaterial * material = [materials firstObject];
        
        [SCNTransaction begin];
        SCNTransaction.animationDuration = 0.5;
        
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            SCNTransaction.animationDuration = 0.5;
            material.emission.contents = [UIColor blackColor];
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor redColor];
        
        [SCNTransaction commit];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
