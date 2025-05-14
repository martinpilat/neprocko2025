import Distribution.Simple.Utils (xargs)
uspDv xs ys = concat $ map (\x -> map (\y -> (x, y)) ys) xs

uspDv2 xs ys = do
    x <- xs
    y <- ys
    test $ x + y < 8
    return (x, y)

test p | p = [()]
       | otherwise = []

uspDv3 xs ys = [(x, y)| x <- xs, y <- ys, x + y < 8]

a = 25214903917 
c = 11
m = 2^48


newtype Stav a r = Stav {bez:: a -> (r, a)}

instance Functor (Stav a) where
    fmap f sar = Stav $ \a -> let (r, ns) = bez sar a in (f r, ns) 

instance Applicative (Stav a) where
    pure a = Stav $ \s -> (a, s)
    -- f <*> sar = TODO

gen :: Stav Integer Integer
gen = Stav $ \x -> (((a*x + c) `mod` m) `div` 2^17, (a*x + c) `mod` m)
