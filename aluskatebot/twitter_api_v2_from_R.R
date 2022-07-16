# twitter_api_v2_from_R.R
# ........................................................
p_path_twitter <- "C:\\Users\\talon\\Dropbox\\git-post-reference-copy\\R\\userpass\\twitter-aluskate-bot.txt"
cre <- read.csv(p_path_twitter, header = TRUE)
# ........................................................
# https://developer.twitter.com/en/docs/tutorials/getting-started-with-r-and-v2-of-the-twitter-api
install.packages("httr")
install.packages("jsonlite")
install.packages("dplyr")

require(httr)
require(jsonlite)
require(dplyr)

bearer_token <- (cre$bot[4])
headers <- c(`Authorization` = sprintf('Bearer %s', bearer_token))

params <- list(`user.fields` = 'description',
               `expansions` = 'pinned_tweet_id')


handle <- 'vaakaruode'
url_handle <- sprintf('https://api.twitter.com/2/users/by?usernames=%s', handle)


handle

response <-
  httr::GET(url = url_handle,
            httr::add_headers(.headers = headers),
            query = params)
obj <- httr::content(response, as = "text")
print(obj)


json_data <- jsonlite::fromJSON(obj, flatten = TRUE) %>% as.data.frame
View(json_data)


url_handle2 <- 'https://api.twitter.com/2/tweets'
params2 <- list(`text` = 'Hello!')

response2 <-
  httr::POST(url = url_handle2,
            httr::add_headers(.headers = headers),
            query = params2)
obj <- httr::content(response2, as = "text")
print(obj)



final <- sprintf(
    "Handle: %s\nBio: %s\nPinned Tweet: %s",
    json_data$data.username,
    json_data$data.description,
    json_data$includes.tweets.text
  )

cat(final)


# twitter help:
# https://github.com/twitterdev


response <-
  httr::POST(url = url_handle,
            httr::add_headers(.headers = headers),
            query = params)
obj <- httr::content(response, as = "text")
print(obj)




# https://cran.r-project.org/web/packages/rtweet/vignettes/auth.html

if (!requireNamespace("httpuv", quietly = TRUE)) {
  install.packages("httpuv")
}


# git remote add origin git@github-vaakaruode:vaakaruode/R.git



