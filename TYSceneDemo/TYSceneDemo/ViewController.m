//
//  ViewController.m
//  TYSceneDemo
//
//  Created by 田宇 on 2019/6/1.
//  Copyright © 2019 田宇. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
#import "GlobeViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet SCNView *sceneView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sceneView.delegate = self;
    
//    self.sceneView.showsStatistics = YES;
    
    SCNScene *scene = [SCNScene sceneNamed:@"ship.scnassets/myship/myship.scn"];
    
    // 添加相机
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:cameraNode];
    
    // 调整视角
    cameraNode.position = SCNVector3Make(0, 0, 15);
    
    // 添加灯光
    SCNNode * lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, -10, 10);
    [scene.rootNode addChildNode:lightNode];
    
    // 添加氛围灯光
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor blackColor];
    [scene.rootNode addChildNode:ambientLightNode];
    
    
//    SCNNode *myship = [scene.rootNode childNodeWithName:@"myship" recursively:YES];
//
//    [myship runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:1]]];
    
    self.sceneView.scene = scene;
    
    self.sceneView.allowsCameraControl = YES;
    
    // 添加点击动作
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:_sceneView.gestureRecognizers];
    _sceneView.gestureRecognizers = gestureRecognizers;
    
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognize {
    
    CGPoint p = [gestureRecognize locationInView:_sceneView];
    //NSLog(@"点击了:%@", p);
    NSArray *hitResults = [_sceneView hitTest:p options:nil];
    
    if ([hitResults count] > 0) {
        
        SCNHitTestResult * result = [hitResults firstObject];
        
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor redColor];
        
        [SCNTransaction commit];
    }
}
- (IBAction)globeClick:(UIButton *)sender {
    
    [self presentViewController:[GlobeViewController new] animated:YES completion:nil];
    
}

@end
