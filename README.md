### OC源码编译，可直接运行、调试，通过它可以更好的理解OC的本质以及底层实现


本项目中使用的是苹果源码 [objc4-781](https://opensource.apple.com/tarballs/objc4/) 版本， 系统版本为```macos 10.15``` ，可以从 [苹果开源源码](https://opensource.apple.com/source/) 和 [官方tarballs](https://opensource.apple.com/tarballs) 查看相关源码和依赖库， 所使用的到的依赖库如下：
```
libdispatch、libpthread、dyld、Libc、libplatform、libauto、libclosure、xnu
```      

<font color=red>以上项目可直接编译使用！如需自己编译，可查看以下步骤！否则可忽略以下步骤！</font>


### 苹果源码编译问题与解决方案
#### 1. macosx.internal 报错
<p align="left" >
  <img src="https://github.com/gltwy/objc4/blob/master/images/image1.png?raw=true" width = 400>
</p>

```
unable to find sdk 'macosx.internal'
```

- 将 ```Build Settings``` ->  ``` Base SDK```
设置为 ``macos 10.15 ``
- 将
``` Valid Architectures ```
删除
``` i386 ```
架构支持


#### 2. file not found 报错
<p align="left" >
  <img src="https://github.com/gltwy/objc4/blob/master/images/image2.png?raw=true" width = 500>
</p>

 - 在工程目录下新建
```Common```
文件夹
 - 之后在 ```Xcode``` ->
```Build Setting``` -> ```Header Search Paths``` 
添加
```$(SRCROOT)/Common ```
- 在```Common```文件夹中新建```sys```文件夹，并从下载的其他的包中找到 ```reason.h``` ，放到```sys```文件夹中即可 <br/> 
- 以下同理<br/>
```
'sys/reason.h' file not found

'mach-o/dyld_priv.h' file not found

'os/lock_private.h' file not found

'os/base_private.h' file not found

'pthread/tsd_private.h' file not found

'System/machine/cpu_capabilities.h' file not found

'os/tsd.h' file not found

'pthread/spinlock_private.h' file not found

'System/pthread_machdep.h' file not found

'CrashReporterClient.h' file not found

'objc-shared-cache.h' file not found

'_simple.h' file not found

'kern/restartable.h' file not found

'Block_private.h' file not found

'objc/objc-block-trampolines.h' file not found
```


#### 3. bridgeos(3.0) 报错
<p align="left" >
  <img src="https://github.com/gltwy/objc4/blob/master/images/image3.png?raw=true" width = 500>
</p>

- 删除```bridgeos(3.0)```即可

#### 4. OS_UNFAIR_LOCK_ADAPTIVE_SPIN 报错

<p align="left" >
  <img src="https://github.com/gltwy/objc4/blob/master/images/image4.png?raw=true" width = 500>
</p>

```
Use of undeclared identifier 'OS_UNFAIR_LOCK_ADAPTIVE_SPIN'
```

将此处修改为```os_unfair_lock_lock(&mLock)```;


#### 5. Use of undeclared identifier xxx
```
Use of undeclared identifier 'DYLD_MACOSX_VERSION_10_11'

Use of undeclared identifier 'DYLD_MACOSX_VERSION_10_14'

Use of undeclared identifier 'DYLD_MACOSX_VERSION_10_13'

Use of undeclared identifier 'DYLD_MACOSX_VERSION_10_12'
```
定义以下宏即可
```swift
#define DYLD_MACOSX_VERSION_10_11 0x000A0B00
#define DYLD_MACOSX_VERSION_10_14 0x000A0E00
#define DYLD_MACOSX_VERSION_10_13 0x000A0D00
#define DYLD_MACOSX_VERSION_10_12 0x000A0C00
```
#### 6. OrderFiles/libobjc.order 报错
```
Can't open order file: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/AppleInternal/OrderFiles/libobjc.order
```
将 ```Build Settings``` - ```Order file``` 路径改为 ```$(SRCROOT)/libobjc.order``` 即可

#### 7.  -lCrashReporterClient 报错
```
ld: library not found for -lCrashReporterClient
```
将 ```Build Settings``` - ```other link flags``` 删除 ```-lCrashReporterClient``` 即可

#### 8. Script 报错
```
/xcodebuild:1:1: SDK "macosx.internal" cannot be located.
/xcrun:1:1: sh -c '/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -sdk macosx.internal -find clang++ 2> /dev/null' failed with exit code 16384: (null) (errno=No such file or directory)
/xcrun:1:1: unable to find utility "clang++", not a developer tool or in PATH
```

将 ```Build Phases``` - ```Run Script(markc)``` 中 ```macosx.internal``` 改为  ```macosx```

#### 9. 新建target测试即可使用
<p align="left" >
  <img src="https://github.com/gltwy/objc4/blob/master/images/image5.png?raw=true" width = 500>
</p>

依赖库图
<p align="left" >
  <img src="https://github.com/gltwy/objc4/blob/master/images/image6.png?raw=true" width = 300>
</p>

### 附注
github 图片不显示配置（亲测可用）

```
sudo /etc/hosts
```

将以下内容添加到 ``` hosts``` 文件即可

```
140.82.114.3      github.com
199.232.69.194    github.global.ssl.fastly.net
185.199.110.153   assets-cdn.github.com
140.82.114.3      gist.github.com

199.232.28.133    raw.githubusercontent.com
199.232.28.133    gist.githubusercontent.com
199.232.28.133    cloud.githubusercontent.com
199.232.28.133    camo.githubusercontent.com
199.232.28.133    avatars0.githubusercontent.com
199.232.28.133    avatars1.githubusercontent.com
199.232.28.133    avatars2.githubusercontent.com
199.232.28.133    avatars3.githubusercontent.com
```
