import Data.Char (toUpper)

main::IO ()
main = do
    x <- getLine
    xx <- getLine
    let y = zpracuj (x ++ xx)
    putStrLn y

test = do
    interact zpracuj

secti2cisla = do
    putStr "zadej prvni cislo: "
    x <- readLn::IO Integer
    putStr "zadej druhe cislo: "
    y <- readLn::IO Integer
    putStrLn $ "Soucet je " ++ show (x+y)

zpracuj = map toUpper