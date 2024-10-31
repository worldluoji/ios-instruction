# 了解Objective-C
Objective-C 是一种基于 C 语言的面向对象编程语言，它在 iOS 和 macOS 开发中有着悠久的历史。尽管 Swift 已经成为苹果主推的语言，但许多存量项目仍然使用 Objective-C，或者在新项目中混合使用 Swift 和 Objective-C。下面是一些 Objective-C 的常用语法和概念：

### 1. 类和对象
Objective-C 使用 `@interface` 和 `@implementation` 来定义类。

```objective-c
// 定义一个接口（类声明）
@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)sayHello;

@end

// 实现接口（类实现）
@implementation Person

- (void)sayHello {
    NSLog(@"Hello, my name is %@ and I am %ld years old.", self.name, (long)self.age);
}

@end
```

### 2. 属性
属性是 Objective-C 中的一个重要特性，用于封装数据成员。你可以使用 `@property` 关键字来声明属性。

```objective-c
@interface Person : NSObject

@property (nonatomic, strong) NSString *name; // 强引用
@property (nonatomic, assign) NSInteger age;  // 基本类型

@end
```

### 3. 方法
方法在 Objective-C 中以 `-` 或 `+` 开头。`-` 表示实例方法，`+` 表示类方法。

```objective-c
- (void)sayHello {
    NSLog(@"Hello, my name is %@ and I am %ld years old.", self.name, (long)self.age);
}

+ (Person *)personWithName:(NSString *)name age:(NSInteger)age {
    Person *person = [[Person alloc] init];
    person.name = name;
    person.age = age;
    return person;
}
```

上述代码定义了一个类方法（也称为静态方法），用于创建并初始化 `Person` 类的一个实例。这个方法接受两个参数，并返回一个 `Person` 对象。
让我们详细解释一下每个部分：

### 方法声明

```objective-c
+ (Person *)personWithName:(NSString *)name age:(NSInteger)age
```

- **`+` 符号**：表示这是一个类方法。类方法是属于类本身的方法，而不是属于类的某个特定实例。你可以通过类名直接调用这些方法，而不需要创建该类的实例。

- **返回类型 `(Person *)`**：这指定了方法的返回值类型。在这个例子中，方法将返回一个 `Person` 类型的对象指针。

- **方法名 `personWithName:age:`**：这是方法的名字。Objective-C 的方法命名通常包含多个部分，每部分后面跟着一个冒号 `:`，表示这里需要传递一个参数。因此，这个方法有两个参数：一个是名字 `name`，另一个是年龄 `age`。

### 参数

- **`name:(NSString *)name`**：第一个参数是一个 `NSString *` 类型的变量，用来接收传入的名字。`name` 是参数的实际名称，在方法体内部使用。
  
- **`age:(NSInteger)age`**：第二个参数是一个 `NSInteger` 类型的变量，用来接收传入的年龄。`age` 也是参数的实际名称，在方法体内部使用。

### 方法实现

```objective-c
Person *person = [[Person alloc] init];
person.name = name;
person.age = age;
return person;
```

- **`[[Person alloc] init]`**：这部分代码首先为 `Person` 类分配内存（`alloc`），然后初始化新创建的对象（`init`）。这会返回一个 `Person` 类的新实例。

- **设置属性**：接下来，新创建的 `person` 实例的 `name` 和 `age` 属性被设置为方法传入的 `name` 和 `age` 值。

- **返回对象**：最后，方法返回这个新创建和初始化的 `Person` 对象。

### 使用示例

如果你有一个 `Person` 类，并且已经实现了上述方法，你可以像这样使用它：

```objective-c
Person *john = [Person personWithName:@"John" age:30];
NSLog(@"Name: %@, Age: %ld", john.name, (long)john.age);
```

这段代码将会创建一个名为 "John" 年龄为 30 的 `Person` 对象，并打印出他的信息。

总结来说，这个方法提供了一种方便的方式来创建 `Person` 类的实例，并且允许你在创建时直接设置其 `name` 和 `age` 属性。

### 4. 初始化
初始化方法通常以 `init` 开头，返回一个已初始化的对象。

```objective-c
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
    }
    return self;
}
```

### 5. 协议（Protocol）
协议类似于 Java 中的接口，定义了一组方法，类可以选择实现这些方法。

```objective-c
@protocol Printable <NSObject>

- (void)print;

@end

@interface Person : NSObject <Printable>

- (void)print {
    NSLog(@"Name: %@, Age: %ld", self.name, (long)self.age);
}

@end
```

### 6. 委托（Delegate）
委托模式是一种设计模式，允许一个对象将某些任务委派给另一个对象。

```objective-c
@protocol MyDelegate <NSObject>

- (void)didFinishTask;

@end

@interface MyClass : NSObject

@property (nonatomic, weak) id<MyDelegate> delegate;

- (void)performTask;

@end

@implementation MyClass

- (void)performTask {
    // 执行一些任务
    [self.delegate didFinishTask];
}

@end
```

### 7. 类扩展（Category）
类扩展允许你在不修改原始类的情况下添加方法。

```objective-c
#import "NSString+MyExtensions.h"

@implementation NSString (MyExtensions)

- (BOOL)containsString:(NSString *)substring {
    return [self rangeOfString:substring].location != NSNotFound;
}

@end
```

### 8. 块（Block）
块是 Objective-C 中的一种匿名函数，类似于 Swift 中的闭包。

```objective-c
typedef void (^CompletionHandler)(NSString *result, NSError *error);

- (void)doSomethingWithCompletion:(CompletionHandler)completion {
    // 执行一些异步操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 模拟异步操作
        sleep(2);
        
        NSString *result = @"Operation completed";
        NSError *error = nil;
        
        // 回到主线程执行 completion block
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(result, error);
        });
    });
}
```
这里，^就代表一个块，返回值是CompletionHandler，有时候会看到
```C
- (void)performOperationWithCompletion:(void (^)(GMRZUACRef *uacRef))completion;
```
这定义了一个没有返回值的块，它接受一个 GMRZUACRef * 类型的参数。这种类型的块通常用作回调，以便在某个操作完成后执行特定的逻辑。


以下是完整调用示例：

定义GMRZUACRef
```C
@interface GMRZUACRef : NSObject
@property (nonatomic, strong) NSString *refId;
@end

@implementation GMRZUACRef
@end
```

定义Class
```C
@interface YourClass : NSObject
- (void)performOperationWithCompletion:(void (^)(GMRZUACRef *uacRef))completion;
@end

@implementation YourClass

- (void)performOperationWithCompletion:(void (^)(GMRZUACRef *uacRef))completion {
    // 模拟异步操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 模拟一些耗时的操作
        sleep(2);

        // 创建一个 GMRZUACRef 实例
        GMRZUACRef *uacRef = [[GMRZUACRef alloc] init];
        uacRef.refId = @"12345";

        // 回到主线程调用 completion 块
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(uacRef);
            }
        });
    });
}

@end
```
调用performOperationWithCompletion方法
```C
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        YourClass *yourInstance = [[YourClass alloc] init];

        [yourInstance performOperationWithCompletion:^(GMRZUACRef *uacRef) {
            NSLog(@"Operation completed with UAC Ref: %@", uacRef.refId);
        }];

        // 为了防止程序立即退出，可以添加一个延迟
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    }
    return 0;
}
```


### 9. 错误处理
Objective-C 使用 `NSError` 对象来处理错误。

```objective-c
- (BOOL)doSomethingWithError:(NSError **)error {
    // 执行一些可能出错的操作
    if (/* 发生错误 */) {
        if (error) {
            *error = [NSError errorWithDomain:@"com.example.error" code:1 userInfo:nil];
        }
        return NO;
    }
    return YES;
}
```

### 10. 内存管理
Objective-C 支持手动内存管理和自动引用计数（ARC）。

#### 手动内存管理
```objective-c
Person *person = [[Person alloc] initWithName:@"John" age:30];
[person release];
```

#### 自动引用计数（ARC）
```objective-c
Person *person = [[Person alloc] initWithName:@"John" age:30];
// ARC 会自动管理内存
```

### 总结
以上是 Objective-C 的一些基本语法和常用概念。虽然 Swift 已经成为主流，但了解和掌握 Objective-C 仍然对维护现有项目或与旧代码集成非常重要。如果你有更多具体的问题或需要更详细的解释，请告诉我！