{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( runBot
    ) where

import qualified Discord  as D
import qualified Discord.Types as D
import qualified Discord.Requests as D
import qualified Data.Text.IO                  as TIO
import           System.Environment (lookupEnv)
import qualified Data.Text                 as T
import           Control.Monad                  ( void
                                                , when
                                                )


runBot :: IO ()
runBot = do
  tokenM <- lookupEnv "DISCORD_TOKEN"
  case tokenM of
    Nothing -> 
      putStrLn "Expected environment variable DISCORD_TOKEN to log in to Discord"
    Just token -> do
      userFacingError <- D.runDiscord $ D.def
        { D.discordToken   = T.pack $ token
        , D.discordOnEvent = eventHandler
        }
      TIO.putStrLn userFacingError

eventHandler :: D.DiscordHandle -> D.Event -> IO ()
eventHandler dis event = case event of
  D.MessageCreate m -> 
    when (not (fromBot m) && isPing (D.messageText m)) $ do
               _ <- D.restCall dis (D.CreateReaction (D.messageChannel m, D.messageId m) "eyes")
               () <$ D.restCall dis (D.CreateMessage (D.messageChannel m) "Pong!")
  _ -> pure ()

fromBot :: D.Message -> Bool
fromBot m = D.userIsBot (D.messageAuthor m)

isPing :: T.Text -> Bool
isPing = ("ping" `T.isPrefixOf`) . T.toLower
