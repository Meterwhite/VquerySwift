# LinkBlock
> [新的ObjC语言效率工具！](https://github.com/Meterwhite/Objc2020)
> 
> [修改Cocoapods源代码!](https://github.com/Meterwhite/ObjcHook4pod)
## 【Introduction/介绍】
* LinkBlock是objc`链式编程`语法糖扩展，可以压缩大量不需要阅读的代码
* 低学习成本，因为它是Fundation API的搬运工
* 持续维护，向后兼容
* 作废API将保留半年
* Syntactic sugar of objc , it use block to reduce code that you don't need to read.
* Easy to use,it is the porter of the Fundation API
* Continuous maintenance, backward compatibility
* Deprecate API will remain for 0.5 year

## 【Import/导入】
* Drag directory `LinkBlock` into project
* `#import "LinkBlock.h"`
* Pod is suported.
```objc
#import "LinkBlock.h"
```


## 【Overview/概览】
### Examples/示例
```objc

NSLog(@"%@",object); 
==> object.nslog();

view.frame = CGRectMake(1, 2, 3, 4);
==> view.viewSetFrame(1, 2, 3, 4);

[self.view addSubview:view];
==> view.viewAddToView(self.view);

CGSize screenSize = [UIScreen mainScreen].bounds.size;
CGRect frame = view.frame;
frame.size.width = screenSize.width;
view.frame = frame;
==> view.objSetScreenValueForFullPath(@"frame->size->width");

[button setTitle:@"Text" forState:UIControlStateNormal];
==> button.btnTitleUIControlStateNormal(@"Text");

[self.view addSubview:viewA];
[self.view addSubview:viewB];
[self.view addSubview:viewC];
==> linkObjs(viewA,viewB,viewC).viewAddToView(self.view);

```

## 【A-B-C-D】
### A Foundation-mirror
- These blocks are copied from Foundation.
- Have the same parameters and return values.
```objc
...strAppend(~)...
...objValueForKey(value,key)...
```
### B Foundation-speed
- Some common parameters has been filled for you.
- It has some of the most basic functions.
```objc
...viewHiddenYES()...
...arrSort(~)...
```
### C Foundation-extend
- Provide some APIs that should have.
- It has some of the most basic functions.
```objc
...strLengthASCII()...
...imgOrientationFix(~)...
...viewAddToView(~)...
```
### D Weak-coding/弱类型编码
- These APIs make the object type no longer important, but only need to care about the function.
- Some APIs provide cross-type conversion capabilities.
```objc
...objAdd(~)...
...strToUIImage()...
```

## 【Call/调用】
### Linkblock will return self or what value method returnd.
```objc
_NonnullObject.linkBlock0().linkBlock1().linkBlock2()...

linkObj(_NullableObject).linkBlock0().linkBlock1().linkBlock2()...
```
### Use linkEnd when getting the return value.If not the result is unexpected.
- LinkBlock return NSNull instead of nil;
```objc
id getTheValue = ...linkBlockReturnAValue().linkEnd;
```
## 【Name/命名】
### linkObject.<KindOfClass+Function[+Enum][+parameter][+others]>
```objc
_NonnullObject.btnTitleUIControlStateNormal()...
```
### Order of parameters/参数顺序
- Order of parameters are the same as Foundation or described by method name.

### Standard/写法规范
```objc
///Important content is in '<>';

_NonnullObject.linkBlock()...;

<linkObj(_NullableObject)>.linkBlock()...;

id getValue = ...linkBlockRerutnValue().<linkEnd>;
```
### Force type declaration/强制类型声明
- Rule:as+ClassName
```objc
NSString text = ...linkBlockRerutnUIView().asUILable.text;
[idObject asUILable].text;
```

### Link Indicate/链条指示
- When linkBlock object has changed,use this block to draw attention and it easy to read./指示,便于阅读
- Link Indicate will do noting, it just return self.
```objc
1.
...linkBlockReturnNotSelf().<thisValue>.someBlock()...;
Use `thisValue`,`thisValues`,`thisNumber` to indicate that linkBlock object has changed.
/指示链条对象变更

2.
linkObjs(...).thisLinkObjs...
Use `thisLinkObjs`,`thisLinkObj` to indicate state of link./指示链条状态

3.
...linkBlockRerutnANumber<As>().<aBOOLValue>...;
All linkBlock return NSNumber value it has suffix 'As'.
Use block named `a+TypeObject` to draw attention./指示NSNumber类型

4.
...linkBlockRerutn<AsWhatSet>(parameterToSet).whatSet...;
If linkBlock return value is parameters of itself ,it has suffix 'AsWhatSet'.
Use `whatSet` to indicate that next linkObj is the parameters of previous linkObj. 
/指示链条对象被切换到参数

Refer to `NSObject+LinkBlock.h`
```

## 【Link objects/多对象】
### Combine link objects into one,more efficient./超效率
```
linkObjs(viewA,viewB,...)...viewAddToView(self.view);

//Hide one view and show others.
linkObjs(viewA,viewB,...).viewHiddenYES().linkAt(selectedIndex).viewHiddenNO();
```
### Code of linkObjs
```objc

Create linkObjs
linkObjs(a,b,c...).thisLinkObjs...;//Main/主要

@[a,b,c...].makeLinkObjs.thisLinkObjs...;//Minor/次要

a.linkPush(b).linkPush(c).thisLinkObjs...;//Minor/次要

Get result
NSArray *getResultInArray = linkObjs...linkEnds;//主要
```
### Modify link obejcts
```
1.
...<linkPop()>.thisLinkObjs...
Remove last link object from linkObjs

2.
linkObjs...<linkAt(index)>.thisLinkObj...
Get linkObj from linkObjs and return it as next linkObj.

3.
...linkLoop(count,^(NSObject* loopObject,NSUInteger idx){
    loopObject.objAdd(~);
})...
Repeat execute the code using block.

*/
```

## 【Simple Conditional/简单条件】
```objc

...aNumberValue.linkIf...linkElse...;

...aNumberValue.linkIf_YES...LinkElse...;

///Force return/强制返回
id resultFromLinkBlock0 = ...linkIf_YES...linkReturn...LinkElse...linkEnd;
```

## 【Others/其他】
- 【调用项目外方法】
```objc
person.objPerformSelectorsWithArgs(~);
```

- 【LinkError】
```objc
If there is no need to crash LinkBlock tends to printed the error by NSLog./无必要则不崩溃
LinkError can response to unknown method and not crash./可以响应未知方法而不崩溃
This feature make linkBlock more secure./更加安全
When unknown method called it will do noting but log itself./响应未知方法时会打印错误信息


Kind of Error：

1.call linkBlock from `nil`
2.Type error 
3.Parameters error


1: Use linkObj(~) to create a secure object.
2,3: This error would be printed by NSLog.
```

## Author
- Contact me : quxingyi@outlook.com


-



-



-


## 【Experimental/实验性的】
### Execute linkBlock by script;/脚本解析
- Describe/描述
```objc
4 ways:

1.
script.linkCodeEval(targetObject,arg...);

2.
targetObject.linkEvalCode(script,arg...);

3. 
EvalLinkBlock(@"代码");//Execute script directly;

4. 
EvalLinkBlockWithTarget(targetObject,arg...);
```

### Detail/详细

```objc

DynamicLink used like linkBlock
1."...actionName()..."The actionName wiil called as linkBlock
2."...actionName...".The actionName will called as property > non-argument method > LinkBlock command

LinkBlock command/命令:
1.CreateCommand:"ClassName+New";
2.LinkBlock macros,like 'NSNil','AttrDictNew'

note:DynamicLink did not suport the function that use argument list.If do it,system will recive only one agument,This will cause potential differences./不支持不定参数方法，否则只接收一个参数


direct value/直接量：
direct value used in '()'.Like:"actionName(3.1415926)"
suport types:number||HexNumber,String,Boolean,c string,char,NSNumber,SEL,struct in NSValue,Class;
Reference:DynamicLinkArgument.h

note:1.If set actionName or func as direct value,it must be non-argument func/方法的直接量必须是无惨的
2.cannot have double quotes in a string/字符串中不再用双引号


Entry order/入参顺序:
One-to-one correspondence/一一对应关系
script:"actionName($0 , 3.14 , $1)" => argument list:($0 , $1)
Only suport set arguments to outer layer,to inner layer func should use direct value.
In argument list use NSNil instead nil,or use direct value nil or NULL in script

return type:In dynamicLink all return type has been boxed./所有返回值都是装箱的
```
