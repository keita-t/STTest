PK
     ��L              test/UT	 #�L[#�L[ux �  �  PK
     v��L�J�w!  !    test/YouSayTest.stUT	 /�L[/�L[ux �  �  TestCase subclass: YouSayTest [
  setUp [
    super setUp
  ]

  tearDown [
    super tearDown
  ]

  testYou [
    self should: [ You isStillAlive ]
  ]

  testTrue [
    self assert: [ true ] value
  ]
]

TestCase subclass: FalseTest [
  testFalse [
    self shouldnt: [ false ]
    ]
]
PK
     ��L�^      package.xmlUT	 #�L[#�L[ux �  �  <package>
  <name>HelloWorld</name>
  <test>
    <prereq>HelloWorld</prereq>
    <prereq>SUnit</prereq>
    <sunit>HelloWorldTest</sunit>
    <filein>test/YouSayTest.st</filein>
  </test>

  <filein>src/HelloWorld.st</filein>
  <filein>src/YouSay.st</filein>
</package>PK
     ��L              src/UT	 #�L[#�L[ux �  �  PK
     4��L���W   W     src/HelloWorld.stUT	 �|L[�|L[ux �  �  Object subclass: World [
    World class >> sayToMe [
      'Hello!' displayNl
    ]
]
PK
     ���L�i��p   p     src/YouSay.stUT	 ۧL[ۧL[ux �  �  Object subclass: #You.
You class extend [ say [ 'Yes' displayNl ] ]
You class extend [ isStillAlive [ ^true ] ]
PK
     ��L                     �A    test/UT #�L[ux �  �  PK
     v��L�J�w!  !            ��?   test/YouSayTest.stUT /�L[ux �  �  PK
     ��L�^              ���  package.xmlUT #�L[ux �  �  PK
     ��L                     �A�  src/UT #�L[ux �  �  PK
     4��L���W   W             ��<  src/HelloWorld.stUT �|L[ux �  �  PK
     ���L�i��p   p             ���  src/YouSay.stUT ۧL[ux �  �  PK      �  �    