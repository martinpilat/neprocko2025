import Control.Applicative (Applicative)
import Foreign (peekArray)
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

ncpz3 pelisky ceny zvire = do
    -- najdi pelisky zvire >>= (\pelisek -> najdi ceny pelisek)
    pelisek <- najdi pelisky zvire
    najdi ceny pelisek

ncpz4 pelisky ceny zvire1 zvire2 = do 
    pel1 <- najdi pelisky zvire1
    c1 <- najdi ceny pel1
    pel2 <- najdi pelisky zvire2
    c2 <- najdi ceny pel2
    return (c1 + c2)