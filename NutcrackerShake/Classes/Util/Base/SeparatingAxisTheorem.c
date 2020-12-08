/*
 *  SeparatingAxisTheorem.c
 *  CollisionDetect
 *
 *  Created by George on 12/24/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "SeparatingAxisTheorem.h"

/*
 * 计算多边形polygon在坐标轴axis上得投影，得到最小值min和最大值max
 */
static inline void projectPolygon(Vect axis, Polygon polygon, float* min, float* max)
{
	float d = vectDot(axis, polygon.vertexes[0]);
	*min = d;
	*max = d;
	for (int i = 0; i < polygon.vertexCount; i++)
	{
		d = vectDot(axis, polygon.vertexes[i]);
		if (d < *min)
		{
			*min = d;
		}
		else
		{
			if (d > *max)
			{
				*max = d;
			}
		}
	}
}

/*
 * 计算圆形circle在坐标轴axis上得投影，得到最小值min和最大值max
 */
static inline void projectCircle(Vect axis, Circle circle, float* min, float* max)
{
	float d = vectDot(axis, circle.o);
	float axisLength = vectLength(axis);
	*min = d - (circle.r * axisLength);
	*max = d + (circle.r * axisLength);
}

/*
 * 计算两个投影得距离
 */
static inline float intervalDistance(float minA, float maxA, float minB, float maxB)
{
	return (minA < minB) ? (minB - maxA) : (minA - maxB);
}

bool polygonCollision(Polygon a, Polygon b)
{
	Vect edge, axis;
	float minA = 0, maxA = 0, minB = 0, maxB = 0;
	
	for (int i = 0, j=a.vertexCount-1; i < a.vertexCount + b.vertexCount; j=i, i++)
	{
		//通过顶点取得每个边
		if (i < a.vertexCount)
		{
			edge = vectSub(a.vertexes[i], a.vertexes[j]);
		}
		else
		{
			edge = vectSub(b.vertexes[i-a.vertexCount], b.vertexes[j-a.vertexCount]);
		}
		
		axis = vectPerp(edge); //向量的垂直向量
		
		//以边的垂线为坐标轴进行投影，取得投影线段[min, max]
		projectPolygon(axis, a, &minA, &maxA);
		projectPolygon(axis, b, &minB, &maxB);
		
		//检查两个投影的距离，如果两投影没有重合部分，那么可以判定这两个多边形没有碰撞
		if (intervalDistance(minA, maxA, minB, maxB) > 0)
		{
			return false;
		}
	}
	
	
	return true;
}

bool polygonCircleCollision(Polygon p, Circle c)
{
	Vect edge, axis;
	float minP = 0, maxP = 0, minC = 0, maxC = 0;
	
    for(int i = 0, j=p.vertexCount-1; i < p.vertexCount; j=i, i++)
    {
        edge = vectSub(p.vertexes[i], p.vertexes[j]);
		axis = vectPerp(edge); // perpendicular to edge     
		
		//以边的垂线为坐标轴进行投影，取得投影线段[min, max]
		projectPolygon(axis, p, &minP, &maxP);
		projectCircle(axis, c, &minC, &maxC);
		
		//printf("%.2f\n", intervalDistance(minP, maxP, minC, maxC));
		
		//检查两个投影的距离，如果两投影没有重合部分，那么可以判定这两个图形没有碰撞
		if (intervalDistance(minP, maxP, minC, maxC) > 0)
		{
			return false;
		}
	}

	for(int i = 0; i < p.vertexCount; i++)
	{
		axis = vectSub(c.o, p.vertexes[i]);
		
		projectPolygon(axis, p, &minP, &maxP);
		projectCircle(axis, c, &minC, &maxC);
		
		//printf("%.2f\n", intervalDistance(minP, maxP, minC, maxC));
		
		if (intervalDistance(minP, maxP, minC, maxC) > 0)
		{
			return false;
		}
	}

	return true;
}

bool circleCollision(Circle c1, Circle c2)
{
	float dis = (c1.o.x - c2.o.x) * (c1.o.x - c2.o.x) +  (c1.o.y - c2.o.y) * (c1.o.y - c2.o.y);
	if (dis > (c1.r + c2.r) * (c1.r + c2.r))
	{
		return false;
	}
	else
	{
		return true;
	}
}

/*
 * straight rectangular直矩形，正矩形
 *
 */
bool rectangleCircleCollision(Rectangle rect, Circle circle)
{
	if (circle.o.x > rect.left - circle.r
		&& circle.o.x < rect.right + circle.r
		&& circle.o.y > rect.bottom - circle.r
		&& circle.o.y < rect.top + circle.r)
	{
		//左上角
		if(circle.o.x < rect.left && circle.o.y > rect.top)
		{
			float dis = disSquare(vectMake(rect.left, rect.top), circle.o);
			if( dis > circle.r * circle.r )
			{
				return false;
			}
		}
		
		if(circle.o.x > rect.right && circle.o.y > rect.top)
		{
			float dis = disSquare(vectMake(rect.right, rect.top), circle.o);
			if( dis > circle.r * circle.r )
			{
				return false;
			}
		}
		
		if(circle.o.x < rect.left && circle.o.y < rect.bottom)
		{
			float dis = disSquare(vectMake(rect.left, rect.bottom), circle.o);
			if( dis > circle.r * circle.r )
			{
				return false;
			}
		}
		
		if(circle.o.x > rect.right && circle.o.y < rect.bottom)
		{
			float dis = disSquare(vectMake(rect.right, rect.bottom), circle.o);
			if( dis > circle.r * circle.r )
			{
				return false;
			}
		}
				
		return true;
	}
	
	return false;
}


//float vectorLength(const Vector& a)
//{
//    float length_squared = a.x*a.x + a.y*a.y;
//    return sqrt(length_squared);
//}


//
//// project polygon along an axis, and find it's dimensions.
//void polygonInterval(const Vector& axis, const Vector* a, int anum, float& min, float& max)
//{
//    min = max = vectorDot(a[0], axis);
//    for(int i = 1; i < anum; i ++)
//    {
//        float d = vectorDot(a[i], axis);;
//        if(d < min) min = d;
//        else if (d > max) max = d;
//    }
//}
//
//// project slphere along an axis, and find it's dimensions.
//void sphereInterval(const Vector& axis, const Vector& c, float r, float& min, float& max)
//{
//    float length = vectorLength(axis);
//    float cn = vectorDot(axis, c);
//    min = cn - (r * length);
//    max = cn + (r * length);
//}
//
//bool collidePolygonPolygonAxis(const Vector& axis, const Vector* a, int anum, const Vector* b, int bnum)
//{
//    float mina, maxa;
//    float minb, maxb;
//	
//    polygonInterval(axis, a, anum, mina, maxa);
//    polygonInterval(axis, b, bnum, minb, maxb);
//	
//    return (mina <= maxb && minb <= maxa);
//}
//
//bool collidePolygonPolygon(const Vector* a, int anum, const Vector* b, int bnum)
//{
//    for(int i = 0, j=anum-1; i < anum; j=i, i++)
//    {
//        Vector edge = vectorSub(a[i], a[j]);
//        Vector axis = vectorPerp(edge); // perpendicular to edge     
//		
//        if(!collidePolygonPolygonAxis(axis, a, anum, b, bnum)) 
//            return false;
//    }
//	
//    for(int i = 0, j=bnum-1; i < bnum; j=i, i++)
//    {
//        Vector edge = vectorSub(b[i], b[j]);
//        Vector axis = vectorPerp(edge); // perpendicular to edge     
//		
//        if(!collidePolygonPolygonAxis(axis, a, anum, b, bnum)) 
//            return false;
//    }
//    return true;
//}
//
//bool collidePolygonSphereAxis(const Vector& axis, const Vector* a, int anum, const Vector& c, float r)
//{
//    float mina, maxa;
//    float minb, maxb;
//	
//    polygonInterval(axis, a, anum, mina, maxa);
//	sphereInterval(axis, c, r, minb, maxb);
//	
//    return (mina <= maxb && minb <= maxa);
//}
//
//bool collidePolygonSphere(const Vector* a, int anum, const Vector& c, float r)
//{
//    for(int i = 0, j=anum-1; i < anum; j=i, i++)
//    {
//        Vector edge = vectorSub(a[i], a[j]);
//        Vector axis = vectorPerp(edge); // perpendicular to edge     
//		
//        if(!collidePolygonSphereAxis(axis, a, anum, c, r)) 
//            return false;
//    }
//	
//    for(int i = 0; i < anum; i++)
//    {
//        Vector axis = vectorSub(c, a[i]);
//		
//        if(!collidePolygonSphereAxis(axis, a, anum, c, r)) 
//            return false;
//    }
//    return true;
//}