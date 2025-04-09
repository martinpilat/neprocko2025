-- komentar
factorial :: Integer -> Integer
--factorial :: (Num p, Ord p) => p -> p
factorial 0 = 1
factorial n | n > 0     = n * factorial (n-1)
            | otherwise = 0 

--pricti1 :: Num a => a -> a
pricti1 x = x+1

myMap f [] = []
myMap f (x:xs) = f x:myMap f xs

myZip [] _          = []
myZip _ []          = []
myZip (x:xs) (y:ys) = (x, y):myZip xs ys

pricitatko1 = myMap pricti1

main = print $ myMap pricti1 [1,2,3]