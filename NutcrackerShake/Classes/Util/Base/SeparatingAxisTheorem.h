/*
 *  SeparatingAxisTheorem.h
 *  CollisionDetect
 *
 *  Created by George on 12/24/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include <stdbool.h>
#include <stdio.h>
#include <math.h>
#include <CoreGraphics/CoreGraphics.h>

//向量
typedef struct Vect
{
	float x,y;
} Vect;

//多边形
typedef struct Polygon
{
	int vertexCount;  //顶点数量
	Vect *vertexes;  //顶点数组
} Polygon;

//圆形
typedef struct Circle
{
	Vect o; // 圆心坐标
	float r; //半径
} Circle;

//矩形
typedef struct Rectangle
{
	float left, right, top, bottom;
} Rectangle;

//矩形构造器
static inline Rectangle rectMake(float left, float right, float top, float bottom)
{
	Rectangle r = {left, right, top, bottom};
	return r;
}

//向量构造器
static inline Vect vectMake(float x, float y)
{
	Vect v = {x, y};
	return v;
}

//向量点乘
static inline float vectDot(Vect v1, Vect v2)
{
	return v1.x*v2.x + v1.y*v2.y;
}

//向量减法
static inline Vect vectSub(Vect v1, Vect v2)
{
	return vectMake(v1.x - v2.x, v1.y - v2.y);
}

//向量长度
static inline float vectLength(Vect v)
{
	return sqrt(v.x*v.x + v.y*v.y);
}


//向量的垂直向量
static inline Vect vectPerp(Vect v)
{
	return vectMake(-v.y, v.x);
}

//两点距离的平方
static inline float disSquare(Vect p1, Vect p2)
{
	return (p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y);
}

/*
 * 圆形与圆形碰撞检测
 */
bool circleCollision(Circle c1, Circle c2);


/*
 * 检测两个多边形是否碰撞，碰撞返回true，不碰撞返回false
 * 必须是两个凸多边形，凹多边形必须拆分成多个凸多边形或三角形
 */
bool polygonCollision(Polygon p1, Polygon p2);

/*
 * 凸多边形与圆形碰撞
 */
bool polygonCircleCollision(Polygon p, Circle c);

/*
 * 正直矩形与圆形碰撞
 */
bool rectangleCircleCollision(Rectangle rect, Circle circle);

