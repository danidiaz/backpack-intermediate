module Intermediate (barAsString) where

import Core (fooAsString)

barAsString :: String
barAsString = "****** " ++ fooAsString ++ " plus bar"

