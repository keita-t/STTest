TestCase subclass: YouSayTest [
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
