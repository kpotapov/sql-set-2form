import Test.HUnit
import SqlTable

foo x y =  x+y

test1 = TestCase (assertEqual "3" 3 (foo 2 1))
        
tests = TestList [ TestLabel "test1" test1 ]


