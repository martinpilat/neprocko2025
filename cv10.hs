import GHC.Base (maxInt)
data Seznam a = Cons a (Seznam a) | SNil deriving Show

-- (.|) = Cons

foldrSeznam :: (t -> p -> p) -> p -> Seznam t -> p
foldrSeznam fCons fNil = g 
    where 
        g SNil = fNil
        g (Cons a as) = fCons a (g as)

instance Foldable Seznam where
    foldr = foldrSeznam

data Strom a = Uzel (Strom a) a (Strom a) | TNil deriving Show

pridejBVS :: Ord a => a -> Strom a -> Strom a
pridejBVS x TNil = Uzel TNil x TNil
pridejBVS x (Uzel l h p) | x < h     = Uzel (pridejBVS x l) h p
                         | otherwise = Uzel l h (pridejBVS x p)

seznamNaBVS::Ord a => [a] -> Strom a
seznamNaBVS x = foldr pridejBVS TNil x

mapStrom :: (t -> a) -> Strom t -> Strom a
mapStrom f TNil = TNil
mapStrom f (Uzel lp h pp) = Uzel (mapStrom f lp) (f h) (mapStrom f pp)

mapStrom' :: (t -> a) -> Strom t -> Strom a
mapStrom' f = g 
    where 
        g TNil = TNil
        g (Uzel lp h pp) = Uzel (g lp) (f h) (g pp)

sectiStrom TNil = 0
sectiStrom (Uzel lp h pp) = (sectiStrom lp) + h + (sectiStrom pp)

minStrom TNil = maxInt
minStrom (Uzel lp h pp) = (minStrom pp) `min` h `min` (minStrom lp)

stromNaSeznam TNil = []
stromNaSeznam (Uzel lp h pp) = (stromNaSeznam lp) ++ [h] ++ (stromNaSeznam pp)

foldStrom fUzel fNil = g
    where 
        g TNil = fNil
        g (Uzel lp h pp) = fUzel (g lp) h (g pp)

sectiStrom' = foldStrom (\x y z -> x + y + z) 0
minStrom' = foldStrom (\lp h pp -> lp `min` h `min` pp) maxInt
stromNaSeznam' = foldStrom (\lp h pp -> lp ++ h:pp) []