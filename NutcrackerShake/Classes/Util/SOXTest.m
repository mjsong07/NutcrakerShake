//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//
#import "SOXTest.h"
#import "SOXGameUtil.h"
#import "SeparatingAxisTheorem.h"
@implementation SoxTest{

}
//CollisionDetection(分离轴) 碰撞
+ (void)testCollisionDetection
{
    
    //	Polygon p1;
    //	Vect p1Vertexes[] = {vectMake(2, 0), vectMake(0, 0), vectMake(1, 2), vectMake(3, 4)};
    //	p1.vertexes = p1Vertexes;
    //	p1.vertexCount = 4;
    //
    //	Polygon p2;
    //	Vect p2Vertexes[] = {vectMake(1, 1.8), vectMake(2, 2.1), vectMake(0, 2.1)};
    //	p2.vertexes = p2Vertexes;
    //	p2.vertexCount = 3;
    //
    //	bool result = polygonCollision(p1, p2);
	
    //	Rectangle r = rectMake(0, 3, 2, 0);
    //	Circle c;
    //	c.o = vectMake(1, 3);
    //	c.r = 0.9;
    //
    //	bool result = rectangleCircleCollision(r, c);
    //
    //	printf("%i", result);
	
	Polygon p1;
	Vect p1Vertexes[] = {vectMake(1, 1), vectMake(2, 0), vectMake(3, 1), vectMake(2, 2)};
	p1.vertexes = p1Vertexes;
	p1.vertexCount = 4;
    
    Polygon p2;
    Vect p1Vertexes2[] = {vectMake(1, 3), vectMake(3, 3), vectMake(3, 2.5), vectMake(1, 2)};
	p2.vertexes = p1Vertexes2;
	p2.vertexCount = 4;
    
    
    
	Circle c;
	c.o = vectMake(0 , 0);
	c.r = 1.3;
	
    //	bool result = polygonCircleCollision(p1, c);
    bool result = polygonCollision( p1, p2);
    if(result){
        CCLOG(@"碰击");
    }else{
       CCLOG(@"没有碰击");
    }
    
}

@end
