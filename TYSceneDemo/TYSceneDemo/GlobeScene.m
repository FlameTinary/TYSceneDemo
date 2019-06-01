//
//  GlobeScene.m
//  TYSceneDemo
//
//  Created by 田宇 on 2019/6/1.
//  Copyright © 2019 田宇. All rights reserved.
//

#import "GlobeScene.h"

@interface GlobeScene()

@property(nonatomic, strong) SCNCamera * camera;
@property(nonatomic, strong) SCNNode *cameraNode;
@property(nonatomic, strong) SCNNode *lightNode;
@property(nonatomic, strong) SCNNode *globeNode;

@end

@implementation GlobeScene

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.camera = [SCNCamera camera];
        self.camera.zNear = 0.01;
        
        self.cameraNode = [SCNNode node];
        self.cameraNode.position = SCNVector3Make(0, 0, 1.5);
        self.cameraNode.camera = self.camera;
        self.camera.focalBlurRadius = 0;
        
        SCNLight *light = [SCNLight light];
        light.type = SCNLightTypeAmbient;
        light.color = [UIColor whiteColor];
        self.lightNode = [SCNNode node];
        self.lightNode.light = light;
        
        
        SCNSphere * sp = [SCNSphere sphereWithRadius:0.3];
        sp.firstMaterial.diffuse.contents = [UIImage imageNamed:@"earth_land_day.jpg"];
        
        SCNNode * spNode = [SCNNode nodeWithGeometry:sp];
        
        SCNText * text = [SCNText textWithString:@"哈哈" extrusionDepth:0.01];
        SCNNode *textNode = [SCNNode nodeWithGeometry:text];
        
        [spNode addChildNode:textNode];

        self.globeNode = [SCNNode node];
        [self.globeNode addChildNode:spNode];
        
        [self.rootNode addChildNode:self.lightNode];
        [self.rootNode addChildNode:self.cameraNode];
        [self.rootNode addChildNode:self.globeNode];
        
        
        
    }
    return self;
}

@end
