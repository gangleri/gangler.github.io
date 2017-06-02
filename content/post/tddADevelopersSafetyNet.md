+++
categories = []
date = "2007-11-10T19:54:30+01:00"
tags = ["tdd"]
thumbnail = ""
aliases = ["2007/11/10/TestDrivenDevelopmentADevelopersSafetyNet.aspx"]
title = "Test Driven Development: A developer’s safety net"

+++

## Introduction
Test Drive Development (TDD) or unit testing are terms you may or may not have 
come across in the past, in this series of posts I’m going to look at TDD, I’ll 
give a brief overview and my arguments for TDD. In later posts, I will begin to 
look more closely at the features available in Visual Studio 2008 to help you 
integrate TDD into your development process.
To start with let us look at the sport of rock climbing. As a climber climbs a 
route, they will place ‘protection’ as they climb. These are clipped onto the 
rope and rock face so that in the event of a fall the ‘system’ catches the 
climber, with the only impact being to their ego.  In contrast, others will 
climb without any safety placed along the route, in the event of a fall in this 
scenario the outcome can be deadly.

The same is true for software development, TDD is your safety net, as your code 
evolves and new features added or existing features extended you can move forward 
with confidence that your existing functionality has remained intact provided all 
the tests pass.  Be honest how many times have you fixed a bug only to find the 
fix you have put in place has resulted in breaking another feature in the system? 
With TDD this situation can be avoided.

Some will make the argument that TDD means more effort thus rendering it 
unfeasible in a commercial software development project. True there is a little 
more effort in writing the test code up front. However, this is a one off, as 
the test once completed should never have to change unless a business requirement 
changes. Plus having the tests in place creates a safety net that allows you to 
move forward with even more confidence, resulting in less time fixing features 
that have been broken by accident, therefore some of the investment in writing 
the tests can be reclaimed.

To successfully use TDD classes must be designed to do one thing and one thing 
only thus allowing testing in complete isolation. This is important as it allows 
you to pinpoint the location of bugs in your code. I’ve heard some tell me how 
this is impossible as this class relies on another class and often a database 
included in the mix. A fair point as systems are comprised of multiple components 
working together to accomplish the desired goal, but it should still be possible 
to isolate each class and test their functionality separately. A friend of mine 
once pointed out, if your classes are that tightly coupled that this is 
unachievable then your code isn’t written right. There’s a lot of truth to this 
statement, and in these posts, I’ll show some examples of how you can use simple 
techniques to isolate a class for testing.


## The TDD Process
Essentially TDD is a very straightforward process. You gather a set of 
requirements, for each case write one or more failing tests. After you have a set 
of failing tests you begin to write implementation code that will pass each test. 
Once this system is completed and all the tests pass you can have confidence the 
delivered code accurately meets the requirements.

You should avoid writing tests that do relate to a requirement as this leads to 
additional implementation code. TDD should help you to focus on writing only the 
code that is required, and less code often means fewer bugs and less late nights.

It is possible to combine multiple classes together and test these. For example, 
if class A uses classes B and C, you could check 'A' allowing it to make the 
necessary calls to 'B' and 'C.' Testing like this will produce integration tests. 
But, to get the benefit of TDD you should first test each of these classes in 
isolation as this allows defects in a particular class to emerge. All the 
examples that I use will focus on testing classes in isolation.


## Getting Started With Visual Studio 2008
I am now going to introduce a simple example of creating a class library and a 
corresponding set of tests for the publicly exposed functionality. In this post 
I’m more concerned with introducing the techniques for creating and running unit 
tests than getting bogged down in a complex real world problem. In later posts I 
will introduce other more advanced features available in Visual Studio 2008 for 
TDD that will become more real world orientated such as testing an ASP.NET 
applications.


### Show me the Code!!
For this example I’m keeping it very, very simple so that we focus on the 
techniques for writing a test and running it, this should take no more than 
fives minutes of your time to run through.

The scenario, you need to provide a class library that provides facilities to 
add, subtract and  multiply integer values. Told you it would be easy, so lets 
get started.

1. Start Visual Studio 2008

1. Create a new blank solution called ‘MyFirstTDD.'

1. Add a new Test project call MathTests to the solution. Right click on the 
solution name in Solution Explorer and select “Add -> New Project …”. Delete 
UnitTest1.cs from the project.

1. Add a new Class Library to the solution called Math. Right click on the name 
of the solution in Solution Explorer and select “Add -> New Project …” Delete 
Class1.cs from the project.

1. Now the test project will reference the classes in the actual class library. 
Therefore you need to add a reference to the class library from the test project. 
To do this right-click on the test project in Solution Explorer and select “Add 
Reference …”. Click the projects tab select Math and click ok.
{{< figure src="/img/vs08_add_reference.jpg" title="Visual Studio 2008 Add Reference" >}}

1. You now have the solution setup, and we can begin to write the code, testing 
first of course.

1. Go to the test project, right-click on the name and select Add -> New Test. 
Name the test CalculatorTests.cs. This will generate a skeleton test class for 
the Calculator class. For now, pay attention to the TestClass and TestMethod 
attributes used at the class and method declarations respectively. The TestClass 
attribute signals that this class contains tests and the TestMethod attribute is 
used to define the individual tests. For methods marked with the TestMethod 
attribute to be considered valid tests they must be in a class marked with the 
TestClass attribute. For now, remember when creating a test class you must mark 
it with the TestClass attribute (Visual Studio will do this automatically when 
using the built-in wizards to add your test class). Also, mark each method you 
wish to use as a test method with the TestMethod attribute.

1. By default Visual Studio adds the method TestMethod1(), you can go ahead and 
delete this as we will be adding our tests with more meaning full names.

1. So now we start the actual development. Firstly we have to provide 
functionality to add, subtract and multiply integer values. This indicates that 
we should at the very least have three tests. So we will start by implementing a 
test that will validate that our Calculator class can add correctly.

1. Open CalculatorTests.cs and add a new method called TestAddPositiveNumbers 
this has a return type of void and takes no parameters, and you should also 
mark it with the TestMethod attribute
{{< gist gangleri 69bcc7acada44a25a715075e3c62a0e0 "gistfile1.cs" >}}

1. We will now implement the body of the test. To start with we will create an 
instance of out Calculator and call the Add method. We will get this test to 
ensure that two plus two always give us four. To do this, we will use hard-coded 
values; this is how you should code all your tests. Using hard coded values. It 
is important to use hard coded values as your tests must be conducted in a 
controlled environment where you know what to expect from the methods you are 
testing.

1. You can see from the code snippet that we create a new calculator and call 
the Add method passing two and two as parameters. Then we use the Assert class 
to check that the returned value matches four. The Assert class has many methods 
that can help with writing unit tests. Fort this post I’ll only be using the 
AreEquals method. This method accepts two parameters and tests that they match if 
they do not match it will raise an exception and cause the test to fail. Later 
posts will look more closely at the Assert class.

1. Now we can try and compile the solution, which not surprisingly fails as we 
have not yet implemented our Calculator class. We will now define the calculator 
class but will only add enough code that allows the test class to compile and 
run; all tests should still fail.

1. Right-click on the Math project in solution explorer and select Add Class.

1. Enter the name Calculator.cs and click ok.

1. Use the code snippet below to define the Add method for the Calculator.
{{< gist gangleri 69bcc7acada44a25a715075e3c62a0e0 "gistfile2.cs" >}}

1. The code should now compile.

1. Once the code compiles, we can run the test, expecting it to fail.

1. To run the tests click Tests -> Run -> Run All Tests in Solution from the 
menu bar or use the keyboard shortcut Ctrl+R, A.

1. The tests will run, and the test results window, shown below will indicate 
that your test has failed. At this time fails are good as we have not implemented 
any code. Therefore if tests pass at this stage, there would be little point in 
having them.
{{< figure src="/img/vs08_test_results.jpg" title="Failing test results" >}}

1. Copy the code snippet below into CalculatorTests.cs compile and run the tests.
{{< gist gangleri 69bcc7acada44a25a715075e3c62a0e0 "gistfile3.cs" >}}

1. Note that only one test has been run. This is because we have not added the 
TestMethod attribute to the TestAddNegativeNumbers method. Apply the attribute 
and run the tests again.

1. We now have two failing tests.

1. You should continue writing tests until all functionality has at least one 
test. As this is only a simple blog, we’ll skip out repeating these steps and 
implement the Add method and verify that both tests pass.

1. Use the code snippet below to implement the add method.
{{< gist gangleri 69bcc7acada44a25a715075e3c62a0e0 "gistfile4.cs" >}}

1. Compile the solution and run the test. In the test result window, you can now 
see that the two tests have passed.
{{< figure src="/img/vs08_test_results_pass.jpg" title="Passing test results" >}}

1. This process of defining tests, verifying that they fail, implementing the 
code and verifying that tests pass should continue until all the functionality 
includes supporting passing tests.




## Conclusion
In this post, I’ve defined the process for TDD and given a simple example of how 
to use TDD with Visual Studio 2008. In my next post, I will look more closely at 
the nuts and bolts of the tools available in Visual Studio 2008 for implementing 
unit tests such as the various attributes and the methods available in the Assert 
class.
If you would like to learn more about TDD, I would recommend the book Test-Driven 
Development in Microsoft.NET by James W. Newkirk and Alexei A. Vorontsov. The 
examples in this book use NUnit, but the techniques apply to Microsoft’s 
implementation of TDD.

Download [Complete solution](https://github.com/gangleri/MyFirstTDD)

