module Lib
    ( getRss
    ) where

import Text.Regex.TDFA ((=~))
import Data.List (intercalate)
import Network.Curl      (curlGetString)
import Network.Curl.Opts
import Text.Feed.Import (parseFeedString)
import Text.Feed.Query (getFeedItems, getItemTitle)
import Codec.Binary.UTF8.String (encodeString)

feedUrl = "http://techblog.holidaycheck.com/feed.xml"

getRss :: IO String
getRss = do
    (_,feed) <- curlGetString feedUrl []
    return $ getMsg $ head $ getItems feed
    where
        getItems = maybe (error "rss parsing failed!") getFeedItems . parseFeedString
        getMsg   = maybe (error "rss-item parsing failed!")  encodeString . getItemTitle

