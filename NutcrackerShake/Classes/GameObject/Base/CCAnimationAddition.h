//
//  CCAnimationAddition.h
//  MonplaPuzzle
//
//  Confidential
//

#import "CCAnimation.h"

/**
 *  @brief  アニメーションの拡張
 */
@interface CCAnimation (CCAnimationAddition)

/**
 *  @brief  アニメーションを作成する
 *  @param  name    アニメーションのフレームの名前
 *  @param  count   フレームの数量
 *  @param  delay   フレームのスピード
 */
+ (CCAnimation *)animationWithFrameName:(NSString *)name frameCount:(NSInteger)count delay:(CGFloat)delay;

/**
 *  @brief  アニメーションを作成する
 *  @param  name    アニメーションのフレームの名前
 *  @param  count   フレームの数量
 *  @param  delay   フレームのスピード
 *  @param  isDesc  逆順に並べるかどうか？
 */
+ (CCAnimation *)animationWithFrameName:(NSString *)name frameCount:(NSInteger)count delay:(CGFloat)delay desc:(BOOL)isDesc;

/**
 *  @brief  アニメーションを作成する
 *  @param  name    アニメーションのフレームの名前
 *  @param  count   フレームの数量
 *  @param  delay   フレームのスピード
 *  @param  begin   フレームindexを始める
 *  @param  isDesc  逆順に並べるかどうか？
 */
+ (CCAnimation *)animationWithFrameName:(NSString *)name frameCount:(NSInteger)count delay:(CGFloat)delay beginIndex:(NSInteger)begin desc:(BOOL)isDesc;

/**
 *  @brief  アニメーションを作成する
 *  @param  name            アニメーションのフレームの名前
 *  @param  orderString     フレームの順番、例えば "1,2,1,3,4" ...
 *  @param  delay           フレームのスピード
 */
+ (CCAnimation *)animationWithFrameName:(NSString *)name frameOrder:(NSString *)orderString delay:(CGFloat)delay;

@end
