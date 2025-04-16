import Data.Char
import Data.Sequence.Internal.Sorting (QList(Nil))

myFoldl _ init []     = init
myFoldl f init (x:xs) = myFoldl f (f init x) xs

myFoldr f init []     = init
myFoldr f init (x:xs) = f x $ myFoldr f init xs

mapFoldr f xs = myFoldr (\x a -> f x:a) [] xs

myFoldr' f init = g 
    where 
        g []     = init
        g (x:xs) = f x $ g xs

type Retezec = [Char]

naVelka::Retezec -> Retezec
naVelka str = map toUpper str

type Sachovnice = [[Integer]]

data Barva = Cervena | Zelena | Modra deriving Show

barvaNaRGB::Barva -> (Int, Int, Int)
barvaNaRGB Cervena = (255, 0, 0) 
barvaNaRGB Zelena  = (0, 255, 0)
barvaNaRGB Modra   = (0, 0, 255)

data BarvaRGB = CervenaRGB | ZelenaRGB |
                ModraRGB | RGB Int Int Int deriving Show


rgbNaBarvu :: (Int, Int, Int) -> BarvaRGB
rgbNaBarvu (255, 0, 0) = CervenaRGB
rgbNaBarvu (0, 255, 0) = ZelenaRGB
rgbNaBarvu (0, 0, 255) = ModraRGB
rgbNaBarvu (r, g, b)   = RGB r g b

data Seznam a = Cons a (Seznam a) | Amazonka deriving Show

mujMapProMujSeznam :: (t -> a) -> Seznam t -> Seznam a
mujMapProMujSeznam _ Amazonka    = Amazonka
mujMapProMujSeznam f (Cons x xs) = Cons (f x) $ mujMapProMujSeznam f xs