PK
     N��L���W   W     HelloWorld.stUT	 SJ[SJ[ux �  �  Object subclass: World [
    World class >> sayToMe [
      'Hello!' displayNl
    ]
]
PK
     ���L���
i   i     package.xmlUT	 �J[�J[ux �  �  <package>
  <name>TestPack</name>

  <filein>HelloWorld.st</filein>
  <filein>Test.st</filein>
</package>PK
     (�L�L=      Test.stUT	 K�H[K�H[ux �  �  Object subclass: Account [
    | balance |
    <comment:
        'I represent a place to deposit and withdraw money'>

    Account class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init.
        ^r
    ]

    init [
        <category: 'initialization'>
        balance := 0
    ]

    printOn: stream [
            <category: 'printing'>
            super printOn: stream.
            stream nextPutAll: ' with balance: '.
            balance printOn: stream
        ]
]
PK
     N��L���W   W             ��    HelloWorld.stUT SJ[ux �  �  PK
     ���L���
i   i             ���   package.xmlUT �J[ux �  �  PK
     (�L�L=              ��L  Test.stUT K�H[ux �  �  PK      �   �    