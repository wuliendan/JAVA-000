# Spring

## Spring AOP

### AOP-面向切面编程

- Spring 早期版本的核心功能，管理对象生命周期与对象装配。

### IoC-控制反转

- 从对象 A 直接引用和操作对象 B，变成对象 A 里只需要依赖一个接口 IB，系统启动和装配阶段，把 IB 接口的实例对象注入到对象 A，这样 A 就不需要依赖一个 IB 接口的具体实现，也就是类 B。

### 代理模式

- 静态代理
- 动态代理

	- JDK 代理

		- 目标对象一定要实现接口
		- 以实现同一个接口方式

	- cglib 代理

		- 目标类不能为 final，目标方法不能 final/static
		- 继承目标类为父类方式

### 切入点表达式

- execution(modifiers-pattern? ret-type-pattern declaring-type-apttern? name-pattern(param-pattern) throws-pattern?) 
- modifiers-pattern?

	- 拦截的方法的访问修饰符

- ret-type-pattern

	- 方法返回值类型

- declaring-type-pattern?name-pattern(param-pattern)

	- 朗杰的方法所在的类

- throws-pattern?

	- 方法声明的异常

### 注解方式实现 AOP

- 引入相关 jar 包
- 配置文件

	- xmlns:context="http://www.springframework.org/schema/context"
xmlns:aop="http://www.springframework,org/schema/aop"
	- <!-- 开启注解扫描 --->
<context:component-scan bese-package="~~"></context:component-scan>
<!-- AOP注解扫描 -->
<aop:aspectj-autoproxy></aop:aspectj-autoproxy>

- 注解

	- @Aspect

		- 执行一个类为切面类

	- @Before

		- 前置通知，目标方法执行前执行

	- @After

		- 后置通知，目标方法指定后执行

	- @AfterReturning

		- 返回后通知，目标方法执行成功之后执行

	- @AfterThrowing

		- 异常通知，目标方法出现异常执行

	- @Around

		- 环绕通知，环绕目标方法执行

	- @Pointcut

		- 定义一个切入点表达式用于其他注解引用

### 配置方式实现 AOP

- xmls:context="http://www.springframework.org/schema/context"
xmls:aop="http://www.springframework.org/schema/aop"
- <!-- 目标对象 -->
<bean id="userDao" class="com.lh.trestaop.UserDao"></bean>
<!-- 实例化切面类 -->
<bean id="aop" class="com.lh.trestaop.TransactionAOP"></bean>
- AOP 相关配置

	- <aop:config></aop:config>

- 定义切入点表达式

	- <aop:pointcut expression="execution(* UserDao.*(..))" id="pt"/>

- 切面类配置

	- <aop:aspect ref="aop">
	- <aop:before method="beginTransaction" pointcut-ref="pt">
	- <aop:after method="commit" pointcut-ref="pt">

## Spring Bean

### Bean加载过程

- 1.实例化 BeanFactoryPostProcessor 实现
- 2.执行 BeanFactoryPostProcessor 的 postProcessBeanFactory 方法
- 3.实例化 BeanPostProcessor 实现
- 4.实例化 InstantiationAwareBeanPostProcessorAdpater 实现类
- 5.执行 InstantiationAwareBeanPostProcessor 的 postProcessBeforeInstantiation 方法
- 6.执行 Bean 的构造器
- 7.执行 InstantiationAwareBeanPostProcessor 的 postProcessPropertyValues 方法
- 8.为 Bean 注入属性
- 9.调用 BeanNameAware 的 setBeanName 方法
- 10.调用 BeanFactoryAware 的 setBeanFactory 方法
- 11.利用 ApplicationContextAware 装配 Bean
- 12.执行 BeanPostProcessor 的 postFrocessBeforeInitalization 方法
- 13.调用 InitializingBean 的 afterPropertiesSet 方法
- 14.调用 <bean> 的 init-method 属性非指定的初始化方法
- 15.执行 BeanPostPocessor 的 postProcessAfterInitialization 方法
- 16.执行 InstantiationAwareBeanPostProcessor 的 postProcessAfterInitialization 方法
- 17.容器初始化成功，执行正常调用后，下面销毁容器
- 18.调用 DiposibleBean 的 destory 方法
- 19.调用 <bean> 的 destroy-method 属性指定的初始化方法

### Spring Bean 生命周期

- 1.实例化（Instantiation）

	- 1.实例化 Bean 实例

- 2.属性赋值（Populate）

	- 2.设置对象属性

- 3.初始化

	- 3.检查 Aware 的相关接口并设置相关依赖
	- 4.BeanPostProcessor 前置处理
	- 5.是否实现 InitializingBean 接口
	- 6.是否配置自定义的 init-method
	- 7.BeanPostProcessor 后置处理

- 4.销毁（Destruction）

	- 8.注册 Destruction 相关回调接口
	- 9.使用
	- 10.是否实现 DisposableBean 接口
	- 11.是否配合自定义的 destory-method

## Spring Boot

### 什么是 Spring Boot

- Spring Boot 使创建独立运行、生产级别的 Spring 应用变得容易，你可以直接运行它。大部分 Spring Boot 应用仅仅需要最少量的配置。

### 功能特性

- 1.创建独立运行的 Spring 应用
- 2.直接嵌入 Tomcat 或 Jetty，Undertow，无需部署 WAR 包
- 3.提供限定性的 starter 依赖简化配置（就是脚手架）
- 4.在必要时自动化配置 Spring 和其他三方依赖库
- 5.提供生产 production-ready 特性，例如指标度量，健康检查，外部配置等
- 6.完全零代码生产和不需要 XML 配置

### 核心原理

- 1.自动化配置：简化配置核心
基于 Configuration, EnableXX, Condition
- 2.spring-boot-starter: 脚手架核心
整合各种第三方类库，协同工具

### 自动配置注解

- @SpringBootApplication

	- Spring Boot 应用标注在某个类上说明这个类是 Spring Boot 的主配置类，Spring Boot 就会运行这个类的 main 方法来启动 Spring Boot 项目。

- @EnableAutoConfiguration

	- 允许 Spring Boot 自动配置注解，开启这个注解以后，Spring Boot 就能根据当前类路径下的包或者类来配置 Spring Bean

- @Configuration

	- 用来代替 applicationContext.xml 配置文件，所有这个配置文件里面能做到的事情都可以通过这个注解所在类来进行注解。

- @SpringBootConfiguration

	- 这个注解就是 @Configuration 注解的变体，只是用来修饰是 Spring Boot 配置而已。

- @ConditionalOnBean

	- 组合 @Conditional 注解，当容器中有指定的 Bean 才开启配置。

- @ConditionalOnClass

	- 组合 @Conditional 注解，当容器中有指定的 Class 才开启配置。

- @ConditionalOnMissingClass

	- 组合 @Confitional 注解，和 @ConditionalOnMessingClass 注解相反，当容器中没有指定的 Class 才开启配置。

- @ConditionalOnProperty

	- 组合 @Conditional 注解，当 SpEL 表达式为 true 时才开启配置。

- @ConditionalOnResource

	- 组合 @Conditional 注解，当类路径下有指定的资源才开启配置。

- @ConditionalOnSingleCandidate

	- 组合 @Conditional 注解，当指定的 class 在容器中只有一个 Bean，或者同时有多个但为首选时才开启配置。

- @ConditionalOnWebApplication

	- 组合 @Conditional 注解，当前项目类型是 WEB 项目才开启配置。

## IOC 容器

### Inversion of Control 控制反转容器

### 创建 Bean

- id

	- 不能以数字开头，不能有特殊符号，在 IOC 容器中 id 是不能重复

- name

	- 可以数字开头，可以由特殊符号
描述的时候可以重复，但是实际使用还是会报错
可以有多个，用逗号分隔

- scope

	- prototype

		- 表示多例，每次获取都创建新的对象

	- singleton

		- 默认值，表示单例

- init-method

	- 指定一个初始化的方法，对象创建成功之后调用

- destory-method

	- 指定一个销毁的方法，在 IOC 容器调用 destory() 方法的时候调用，单例时有效

- lazy-init

	- 延时初始化，单例有效

### 创建字符串

- String str = new String("AA")

	- <bean id="str" class="java.lang.String" >
<constructor-arg value="AA"></constructor-arg></bean>

### 创建对象

- 调用无参构造方法

	- <bean id="user1" class="com.lh.User" >
<constructor-arg index="0" type="String" ref="str"></constructor-arg></bean>
	- constructor-arg：构造方法赋值参数
	- index：赋值索引，不写的话按照默认顺序
	- type：说明参数类型
	- value：要赋值的内容。字符串，会自动根据类型转换
	- ref：应用容器中现有对象赋值

### 工厂模式

- 静态工厂
- 非静态工厂
- 指定参数的工厂

## Spring 框架设计

### 常用模块

- 核心容器

	- 核心容器提供 Spring 框架的基本功能。核心容器的主要组件是 BeanFactory，它是工厂模式的实现。BeanFactory 使用控制反转（IOC）模式将应用程序的配置和依赖性规范与实际的应用程序代码分开。

- Spring 上下文

	- Spring 上下文是一个配置文件，向 Spring 框架提供上下文信息。Spring 上下文包括企业服务，例如 JNDI，EJB，电子邮件，国际化，校验和调度功能。

- Spring AOP

	- 通过配置管理特性，Spring AOP 模块直接面向切面的编程功能集成到了 Spring 框架中。可以将一些通用任务，如安全、事务、日志等集中进行管理，提高了复用性和管理的便捷性。

- Spring DAO

	- 为 JDBC DAO 抽象层提供了有意义的异常层次结构，可用该结构来处理异常处理和不同数据库供应商抛出的错误消息。异常层次结构简化了错误处理，并极大地降低了需要编写地异常代码数量。Spring DAO 的面向 JDBC 的异常遵从通用的 DAO 异常层次结构。

- Spring ORM

	- Spring 框架插入了若干个 ORM 框架，从而提供了 ORM 的对象关系工具，其中包括 JDO、Hibernate 和 iBatis SQL Map。所有这些都遵从 Spring 的通用事务和 DAO 异常层次结构。

- Spring Web 模块

	- Web 上下文模块建立在应用程序上下文模块之上，为基本 Web 的应用程序提供了上下文。所以，Spring 框架支持与 Jakarta Struts 的集成。Web 模块还简化了处理多部分请求以及将请求参数绑定到域对象的工作。

- Spring MVC 框架

	- MVC 框架是一个全功能的构建 Web 应用程序的 MVC 实现。通过策略接口，MVC 框架变成为高度可配置的，MVC 容纳了大量试图技术，其中包括 JSP、Velocity、Tiles、iText 和 POI。

### Spring framework 6大模块

- 1.Core：Bean/Context/AOP
- 2.Testing: Mock/TestContext
- 3.DataAccess: Tx/JDBC/ORM
- 4.Spring MVC/WebFlux: web
- 5.Integration: remoting/JMS/WS
- 6.Languages: Kotlin/Groovy

## Spring 特征

### 轻量

- 从大小与开销两方面而言 Spring 都是轻量的。完整的 Spring 框架可以在一个大小只有 1M 多的 JAR 文件里发布，并且 Spring 所需的处理开销也是微不足道的

### 控制反转

- Spring 通过一种称作控制反转 IOC 的技术促进了低耦合
- 当应用了 IOC，一个对象依赖的其他对象会通过被动的方式传递进来，而不是这个对象自己创建或者查找依赖对象

### 面向切面

- Spring 支持面向切面的编程，并且把应用业务逻辑和系统服务分开

### 容器

- Spring 包含并管理应用对象的配置和生命周期，在这个意义上它是一种容器，你可以配置你的每个 bean 如何被创建---基于一个可配置原型，你的 bean 可以创建一个单纯的实例或者每次需要时都生成一个新的实例---以及它们是如何相互关联的。

### 框架

- Spring 可以将简单的组件配置、组合成为复杂的应用。
- 在 Spring 中，应用对象被声明式地组合，典型的是在一个 XML 文件里
- Soring 也提供了很多基础功能（事务管理、持久化框架集成等），将应用逻辑的开发留给开发者。

## Spring技术发展

### 2004年03月，1.0 版发布

### 2006年10月，2.0 版发布

### 2007年11月，更名为 SpringSource，同时发布了 Spring 2.5

### 2009年12月，Spring 3.0 发布

### 2013年12月，Pivotal 宣布发布 Spring 框架 4.0

### 2017年09月，Spring 5.0 发布

