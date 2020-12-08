/*
 * cocos2d for iPhone: http://www.cocos2d-iphone.org
 *
 * Copyright (c) 2008-2010 Ricardo Quesada
 * Copyright (c) 2011 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */


// cocos2d 
#import "SoxCCParticleExplosion.h"
#import "CCTextureCache.h"
#import "CCDirector.h"
#import "CGPointExtension.h"



//
// ParticleExplosion
//
@implementation SoxCCParticleExplosion


+(id) objInit:(NSUInteger)total :(NSString*)fileName :(CGPoint)p
{
    SoxCCParticleExplosion *particle = [SoxCCParticleExplosion node ];
    particle.totalParticles = total;
     particle.position = p;
    if(fileName!=nil){
         particle.texture = [[CCTextureCache sharedTextureCache] addImage:fileName];
    }
    return particle;
}


+(id) objInit:(NSUInteger)total :(NSString*)fileName
{
    SoxCCParticleExplosion *particle = [SoxCCParticleExplosion node ];
    particle.totalParticles = total;
    if(fileName!=nil){
        particle.texture = [[CCTextureCache sharedTextureCache] addImage:fileName];
    }
    return particle;
}

-(id) init
{
	return [self initWithTotalParticles:10];
}

-(id) initWithTotalParticles:(NSUInteger)p
{
	if( (self=[super initWithTotalParticles:p]) ) {
		
		self.emitterMode = kCCParticleModeGravity;
		// Gravity Mode: gravity
		//self.gravity = ccp(0,0);
		// Gravity Mode: speed of particles
		self.speed = 60;
		self.speedVar = 10;
        
        _duration = 0.1f;
		
        // Gravity Mode: radial
		self.radialAccel = 0;
		self.radialAccelVar = 0;
        
		// Gravity Mode: tagential
		self.tangentialAccel = 0;
		self.tangentialAccelVar = 0;
        
		// _angle
		_angle = 90;
		_angleVar = 140;
        
		// emitter position
		self.posVar = CGPointZero;
        
		// _life of particles
		_life = 1.0f;
		_lifeVar = 1;
		// size, in pixels
		_startSize = 15.0f;
		_startSizeVar = 2.0f;
        
        
        if(G_IS_IPAD){//ipad特殊处理
            _startSize = _startSize*2 ;
          //  self.speed = self.speed *2;
        }
        
        
		_endSize = kCCParticleStartSizeEqualToEndSize;
        
		// emits per second
		_emissionRate = _totalParticles/_duration;
        
        self.startColor =[self rgbToColor4F:255 :255 :0 :255];
        self.startColorVar =[self rgbToColor4F:0 :0 :0 :255];
        self.endColor =[self rgbToColor4F:255 :255 :0 :255];
        self.endColorVar =[self rgbToColor4F:0 :0 :0 :255];
		// additive
		self.blendAdditive = NO;
	}
    
	return self;
}

- (ccColor4F) rgbToColor4F:(float)r :(float)g :(float)b :(float)a
{
	return (ccColor4F) {r/255.0f, g/255.0f, b/255.0f, a/255.0f};
}
@end

