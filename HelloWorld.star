PK
     k�L              test/UT	 ��K[��K[ux �  �  PK
     ��L�$�   �     test/YouSayTest.stUT	 ��K[��K[ux �  �  TestCase subclass: YouSayTest [
  setUp [
    super setUp
  ]

  tearDown [
    super tearDown
  ]

  testYou [
    self should: [ ^You isStillAlive ]
  ]
]
PK
     k�L�^      package.xmlUT	 ��K[��K[ux �  �  <package>
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
     k�L              src/UT	 ��K[��K[ux �  �  PK
     N��L���W   W     src/HelloWorld.stUT	 SJ[��J[ux �  �  Object subclass: World [
    World class >> sayToMe [
      'Hello!' displayNl
    ]
]
PK
     W��L�i��p   p     src/YouSay.stUT	 &CK[&CK[ux �  �  Object subclass: #You.
You class extend [ say [ 'Yes' displayNl ] ]
You class extend [ isStillAlive [ ^true ] ]
PK
     k�L                     �A    test/UT ��K[ux �  �  PK
     ��L�$�   �             ��?   test/YouSayTest.stUT ��K[ux �  �  PK
     k�L�^              ��(  package.xmlUT ��K[ux �  �  PK
     k�L                     �Az  src/UT ��K[ux �  �  PK
     N��L���W   W             ���  src/HelloWorld.stUT SJ[ux �  �  PK
     W��L�i��p   p             ��Z  src/YouSay.stUT &CK[ux �  �  PK      �      