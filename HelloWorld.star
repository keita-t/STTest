PK
     [�L              test/UT	 ރK[߃K[ux �  �  PK
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
     [�L�^      package.xmlUT	 ރK[ރK[ux �  �  <package>
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
     [�L              src/UT	 ރK[߃K[ux �  �  PK
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
     [�L                     �A    test/UT ރK[ux �  �  PK
     ��L�$�   �             ��?   test/YouSayTest.stUT ��K[ux �  �  PK
     [�L�^              ��(  package.xmlUT ރK[ux �  �  PK
     [�L                     �Az  src/UT ރK[ux �  �  PK
     N��L���W   W             ���  src/HelloWorld.stUT SJ[ux �  �  PK
     W��L�i��p   p             ��Z  src/YouSay.stUT &CK[ux �  �  PK      �      