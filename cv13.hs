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
    fmap f sar = Stav $ \a -> let (r, ns) = bez sar a 
                              in (f r, ns) 

instance Applicative (Stav a) where
    pure a = Stav $ \s -> (a, s)
    sab <*> sa = Stav $ \s -> let (ab, ns) = bez sab s 
                                  (a, ns2) = bez sa ns
                              in (ab a, ns2)

instance Monad (Stav a) where
    --(>>=)::Stav s a -> (a -> Stav s b) -> Stav s b
    h >>= f = Stav $ \s -> let (a, ns) = bez h s
                               g       = f a 
                           in  bez g ns

gen :: Stav Integer Integer
gen = Stav $ \x -> (((a*x + c) `mod` m) `div` 2^17, (a*x + c) `mod` m)

seed :: Integer -> Stav Integer ()
seed n = Stav $ \_ -> ((), n)

test2 = do
    seed 11
    x <- gen
    y <- gen
    return $ x+y 