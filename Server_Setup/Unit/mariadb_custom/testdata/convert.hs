import System.IO
import Data.List.Split

-- ,を付与して文字列を結合
listToLine :: [String] -> String
listToLine = foldl1 (\acc x -> acc ++ "," ++ x)

-- 先頭に通し番号を付与
addIndex :: [String] -> [String]
addIndex = zipWith (\ a b -> show a ++ "," ++ b) [1..]

-- ",半角空白を削除
dropdQuotation :: [String] -> [String]
dropdQuotation = fmap (filter (/= '"') . filter (/= ' '))

main:: IO()
main = do
        handle <- openFile "./x-ken-all.csv.csv" ReadMode
        contents <- hGetContents handle
        -- putStrLn contents
        let line = lines contents
        (writeFile "./x-ken-all.csv.csv" . unlines) $ addIndex $ dropdQuotation $ fmap (listToLine . take 9 . splitOn "," ) line

        hClose handle
