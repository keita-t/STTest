TestCase subclass: YouSayTest [
  setUp [
    super setUp.
  ]

  tearDown [
    super tearDown
  ]

  testYou [
    self should: [ ^You isStillAlive ]
  ]

  testTrue [
    self assert: [ ^true ] value
  ]
]

TestCase subclass: FalseTest [
  testFalse [
    self assert: [ ^false ] value
    ]
]
