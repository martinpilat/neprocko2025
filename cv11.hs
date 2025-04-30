data Pair a b = Pair a b
data Seznam a = Cons a (Seznam a) | Nic deriving Show
data Sum a = S a deriving Show
data Prod a = P a deriving Show

class Pologrupa a where 
    spoj :: a -> a -> a
    prazdny:: a

instance Pologrupa (Seznam a) where 
    spoj Nic as = as
    spoj (Cons a as) bs = Cons a $ spoj as bs

    prazdny = Nic

instance Num a => Pologrupa (Sum a) where
    spoj (S a) (S b) = S (a + b)

    prazdny = S 0

instance Num a => Pologrupa (Prod a) where 
    spoj (P a) (P b) = P (a*b)
    prazdny = P 1

instance Semigroup (Seznam a) where 
    (<>) Nic as = as
    (<>) (Cons a as) bs = Cons a $ spoj as bs

instance Monoid (Seznam a) where
    mempty = Nic

instance Num a => Semigroup (Sum a) where
    (S a) <> (S b) = S (a + b)

instance Num a => Monoid (Sum a) where
    mempty = S 0

instance Num a => Semigroup (Prod a) where 
    (P a) <> (P b) = P (a*b)

instance Num a => Monoid (Prod a) where
    mempty = P 1