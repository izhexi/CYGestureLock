# CYGestureLock 简单的手势解锁
用CG画的手势密码。
使用简单。
/**
 *  用在有返回按钮的情况，进行手势密码的设置，解锁、修改，删除，以push 方式呈现
 *
 *  @param controller
 *  @param lockType           锁操纵类型：设置、修改、解锁等
 *  @param animated           是否有push 动画
 *  @param unLockSuccessBlock 解锁成功后回调
 */
+ (void)pushLockControllerForm:(UIViewController *)controller typed:(CYGestureLockViewType)lockType animted:(BOOL)animated successBlock:(CYGestureLockViewBlock)unLockSuccessBlock;

/**
 *  用在不需要返回按钮、主要用于解锁 以present方式呈现
 *
 *  @param controller
 *  @param lockType
 *  @param animated
 *  @param showBack 左上角返回按钮
 *  @param unLockSuccessBlock
 */
+ (void)presentLockControllerFrom:(UIViewController *)controller typed:(CYGestureLockViewType)lockType animted:(BOOL)animated showBack:(BOOL)showBack successBlock:(CYGestureLockViewBlock)unLockSuccessBlock;
