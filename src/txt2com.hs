import qualified Data.ByteString as BS
import Data.ByteString (ByteString)
import Data.List (intercalate)
import Numeric (readHex)
import System.Environment (getArgs)

-- Convert a hexadecimal string to a byte string
hexStringToBytes :: String -> ByteString
hexStringToBytes hexStr =
    let hexWords = words hexStr  -- Split space-separated hex numbers
        hexValues = map (fst . head . readHex) hexWords  -- Convert hex to integer
    in BS.pack hexValues  -- Convert to byte sequence

main :: IO ()
main = do
    args <- getArgs
    let inputFile = if null args then "input.txt" else head args
        outputFile = "output.com"

    -- Read hexadecimal text from an input file
    content <- readFile inputFile
    let binaryData = hexStringToBytes content

    -- Write binary data
    BS.writeFile outputFile binaryData
    putStrLn $ "You've created a binary file!"
