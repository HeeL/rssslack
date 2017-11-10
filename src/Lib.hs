module Lib
    ( parseRss
    ) where

import Text.Regex.TDFA ((=~))
import Data.List (intercalate)
import Network.Curl      (curlGetString)
import Network.Curl.Opts
import Text.Feed.Import (parseFeedString)
import Text.Feed.Query (getFeedItems, getItemTitle, getItemLink)
import Codec.Binary.UTF8.String (encodeString)

feedUrl = "http://techblog.holidaycheck.com/feed.xml"

parseRss :: IO (String, String)
parseRss = do
    (_,feed) <- curlGetString feedUrl []
    let item = head $ getItems feed
    return (getTitle item, getLink item)
    where
        getItems = maybe (error "rss parsing failed!") getFeedItems . parseFeedString
        getTitle = maybe (error "rss-item parsing failed!") encodeString . getItemTitle
        getLink = maybe (error "rss-item parsing failed!") encodeString . getItemLink
