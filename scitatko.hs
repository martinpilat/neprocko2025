import System.Environment (getArgs)
import Distribution.Simple.Utils (safeHead, intercalate)
import Data.Maybe (isJust, fromMaybe)
main = do
    args <- getArgs
    let arg = safeHead args `orDefault` "cisla.txt"
    obsah <- readFile arg
    let soucet = foldl (+) 0 $ map (\x -> read x::Integer) 
                     $ lines obsah
    print soucet

orDefault::Maybe a -> a -> a
orDefault (Just a) _ = a
orDefault Nothing def = def

generuj :: (Show a, Num a, Enum a) => a -> IO ()
generuj n = do
    let cisla = intercalate "\n" $ map show [1..n]
    writeFile ("cisla_"++show n++".txt")  cisla