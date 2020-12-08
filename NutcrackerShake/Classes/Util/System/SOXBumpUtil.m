//
//  SOXMapUtil.m
//  SoxFrame
//
//  Created by jason yang on 13-5-27.
//
//

#import "SOXBumpUtil.h"

#import "SeparatingAxisTheorem.h"

@implementation SOXBumpUtil

+ (BOOL)chkIsBumpCircle:(CCSprite*)rect :(CCSprite*)circle
{
    
    float w2 =  rect.contentSize.width/2;
    float h2 =  rect.contentSize.height/2;
    
    float p_x =  rect.position.x;
    float p_y =  rect.position.y;
    
    
    Vect l1 =vectMake(p_x-w2, p_y+h2);//左上角开始
    Vect l2 =vectMake(p_x+w2, p_y+h2);//右上角
    
    Vect l3 =vectMake(p_x+w2, p_y-h2);//左下角
    Vect l4 =vectMake(p_x-w2, p_y-h2);//左下角
    
	Polygon p1;
	Vect p1Vertexes[] =   {l1,l2,l3,l4};
	p1.vertexes = p1Vertexes;
	p1.vertexCount = 4;
    
	Circle c;
	c.o = vectMake(circle.position.x , circle.position.y);
	c.r = circle.contentSize.width/2;//-15
    
    bool result = polygonCircleCollision(p1, c);
   // [SOXDebug logTagFloat:@"rect" :(p_y-h2)]   ;
   // [SOXDebug logTagFloat:@"circle" :(circle.position.y+c.r) ]   ;
    if(result){
        result = true;
    }
    return result;
}

+ (BOOL)chkIsBumpByRect:(CCSprite*)rect :(CCSprite*)circle
{
    bool result = false;
    CGRect rect1 =  [SOXBumpUtil spriteToRect:rect];
    CGRect rect2 =  [SOXBumpUtil spriteToRect:circle];
    [SOXDebug logTagFloat:@"rect" :(rect1.origin.y)]   ;
    [SOXDebug logTagFloat:@"circle" :(rect2.origin.y +rect2.size.height ) ]   ;
    if (CGRectIntersectsRect(rect1, rect2)) {
        result = true;
    }
    return result;
    // bool result = polygonCollision( p1, p2);
}

//获取碰撞对象的 距离差
+ (float)getBumpDistance:(CCSprite*)rect :(CCSprite*)circle
{ 
    CGRect rect1 =  [SOXBumpUtil spriteToRect:rect];
    CGRect rect2 =  [SOXBumpUtil spriteToRect:circle];
    [SOXDebug logTagFloat:@"rect" :(rect1.origin.y)]   ;
    [SOXDebug logTagFloat:@"circle" :(rect2.origin.y +rect2.size.height ) ]   ;
    float distance =(rect2.origin.y +rect2.size.height ) -rect1.origin.y;
    return distance;
}
//获取碰撞对象的 距离差
+ (float)getBumpDistance2:(CCSprite*)rect :(CCSprite*)circle
{
    float distance = 0 ;
    CGRect rect1 =  [SOXBumpUtil spriteToRect:rect];
    CGRect rect2 =  [SOXBumpUtil spriteToRect:circle];
    float c_x=  circle.position.x;//获取半径
    float r_x=  rect.position.x;//获取半径
    
    float c_r=  rect2.size.width/2;//获取半径
    float c_r_min = c_x -c_r/5;
    float c_r_max = c_x +c_r/5;
    if(r_x >c_r_min && r_x < c_r_max){
       // [SOXDebug logTagFloat:@"rect" :(rect1.origin.y)]   ;
       // [SOXDebug logTagFloat:@"circle" :(rect2.origin.y +rect2.size.height ) ]   ;
        distance =(rect2.origin.y +rect2.size.height ) -rect1.origin.y;
    }
      return distance;
    
}

+ (CGRect)spriteToRect:(CCSprite*)sp
{
    // CGRect rect1=sp.boundingBox;// CGRectMake(sp.position.x - sp.boundingBox.size.width/2,
    //                                sp.position.y - sp.textureRect.size.height/2,
    //                                sp.textureRect.size.width,
    //                                sp.textureRect.size.height);
    //        CGRect rect1=sp.textureRect;
    CGRect rect1=  CGRectMake(sp.position.x-sp.contentSize.width/2, sp.position.y-sp.contentSize.height/2, sp.contentSize.width, sp.contentSize.height);
    
    return rect1;
} 


+ (bool)test:(int)m_radius :(CCSprite*)m_center  :(CCSprite*)rect   {
    
    int arcR = (int)m_radius;//圆形半径
    int arcOx = (int)m_center.position.x;//圆心X坐标
	int arcOy = (int)m_center.position.y;//圆心Y坐标
    
    int rectX = (int)rect.position.x-rect.contentSize.width/2;//长方形左上角X坐标
    int rectY = (int)rect.position.x+rect.contentSize.height/2;//长方形右上角Y坐标
    int rectW = rect.contentSize.width;//长方形宽
    int rectH = rect.contentSize.height;//长方形高
    
    /*
     
     int rectX = (int)rect.getMinX();//长方形左上角X坐标
     int rectY = (int)rect.getMaxY();//长方形右上角Y坐标
     int rectW = rect.getMaxX()-rectX;//长方形宽
     int rectH = rect.getMaxY()-rectY;//长方形高
     */
    if(((rectX-arcOx) * (rectX-arcOx) + (rectY-arcOy) * (rectY-arcOy)) <= arcR * arcR)
       	return true;
    if(((rectX+rectW-arcOx) * (rectX+rectW-arcOx) + (rectY-arcOy) * (rectY-arcOy)) <= arcR * arcR)
        return true;
	if(((rectX-arcOx) * (rectX-arcOx) + (rectY+rectH-arcOy) * (rectY+rectH-arcOy)) <= arcR * arcR)
        return true;
    if(((rectX+rectW-arcOx) * (rectX+rectW-arcOx) + (rectY+rectH-arcOy) * (rectY+rectH-arcOy)) <= arcR * arcR)
        return true;
    //分别判断矩形4个顶点与圆心的距离是否<=圆半径；如果<=，说明碰撞成功
    
    
    int minDisX = 0;
    if(arcOy >= rectY && arcOy <= rectY + rectH){
        if(arcOx < rectX)
			minDisX = rectX - arcOx;
        else if(arcOx > rectX + rectW)
            minDisX = arcOx - rectX - rectW;
        else
            return true;
        if(minDisX <= arcR)
            return true;
    }//判断当圆心的Y坐标进入矩形内时X的位置，如果X在(rectX-arcR)到(rectX+rectW+arcR)这个范围内，则碰撞成功
    
    int minDisY = 0;
	if(arcOx >= rectX && arcOx <= rectX + rectW){
        if(arcOy < rectY)
            minDisY = rectY - arcOy;
       	else if(arcOy > rectY + rectH)
            minDisY = arcOy - rectY - rectH;
       	else
            return true;
        if(minDisY <= arcR)
            return true;
    }//判断当圆心的X坐标进入矩形内时Y的位置，如果X在(rectY-arcR)到(rectY+rectH+arcR)这个范围内，则碰撞成功
	return false;
    
}


@end
