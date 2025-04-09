prime::Integer -> Bool
prime n | n < 2     = False
        | otherwise = all (nedelitelne n) $
        takeWhile (\x -> x*x <= n) [2..]

my_tw::(a -> Bool) -> [a] -> [a]
my_tw _ []                 = []
my_tw p (a:as) | p a       = a : my_tw p as
               | otherwise = []

myTW _ [] = []
myTW p (a:as) = if p a then a : myTW p as else []

-- cislo a je delitelne cislem b
nedelitelne a b = a `mod` b /= 0

primes :: [Integer]
primes = filter prime [2..]

(+!) :: Integral a => a -> a -> Bool
(+!) a b = a `mod` b /= 0

pricti1 :: Double -> Double
pricti1 = (/2).(+1)

myZipWith f as bs = 
    map (uncurry f) $ zip as bs

myZipW f [] _          = []
myZipW f _ []          = []
myZipW f (x:xs) (y:ys) = f x y:myZipW f xs ys