import Control.Applicative (Applicative)
data Mozna a = Proste a | Nic deriving Show 

najdi::Eq a => [(a, b)] -> a -> Mozna b
najdi [] _ = Nic
najdi (x:xs) a | a == fst x = Proste $ snd x
               | otherwise  = najdi xs a

pelisky = [("pes", "bouda"), ("kocka", "krabice"), ("pavouk", "roh")]
ceny = [("bouda", 100), ("krabice", 10)]

-- najdi cenu pro zvire
ncpz pelisky ceny zvire = 
    case najdi pelisky zvire of 
        Nic -> Nic
        Proste pelisek -> najdi ceny pelisek

safeSqrt x | x >= 0 = Proste $ sqrt x
           | otherwise = Nic

safeLog x | x > 0 = Proste $ log x
          | otherwise = Nic

safeSqrtLog x = 
    case safeLog x of
        Nic -> Nic
        Proste y -> safeSqrt y

andThen::Mozna b -> (b -> Mozna c) -> Mozna c
andThen Nic _ = Nic
andThen (Proste b) f = f b

ssl :: (Ord c, Floating c) => c -> Mozna c
ssl x = safeLog x `andThen` safeSqrt

ncpz2 pelisky ceny zvire = 
    (najdi pelisky) zvire `andThen` (najdi ceny)

uprav::(a -> b)->Mozna a -> Mozna b
uprav _ Nic = Nic
uprav f (Proste a) = Proste $ f a

instance Functor Mozna where
    fmap = uprav

instance Applicative Mozna where
    pure = Proste
    Nic <*> _ = Nic
--    _ <*> Nic = Nic
    Proste f <*> ma = fmap f ma

instance Monad Mozna where
    (>>=) = andThen