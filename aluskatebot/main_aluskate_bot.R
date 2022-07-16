# ........................................................
# main_aluskate_bot.R
# ........................................................
# Twitter R experiments
# 16.7.2022: elevated API access needed for rtweet posts
# - analysis is possible
# API v2 access to account tested
# ........................................................
install.packages('rtweet')
library(rtweet) # WARNING: Rtools is required to build R packages but is not currently installed.
# ........................................................
p_path_twitter <- "C:\\Users\\talon\\Dropbox\\git-post-reference-copy\\R\\userpass\\twitter-aluskate-bot.txt"
cre <- read.csv(p_path_twitter, header = TRUE)
# ........................................................
# https://www.r-bloggers.com/2022/04/pulling-twitter-engagements-using-the-v2-api-as-well-as-rtweet/
bearer_token <- cre$bot[4]
headers <- c(`Authorization` = sprintf('Bearer %s', bearer_token))
# ........................................................
# Get Twitter id for vaakaruode:
# https://commentpicker.com/twitter-id.php
user_id <- cre$bot[1]
favorites <- rtweet::get_favorites(user = user_id)
# Authentication complete. Please close this page and return to R.
# ........................................................
## get status IDs of vaakaruode's friend's [https://mkearney.github.io/nicar_tworkshop/#18]
fds <- get_friends("vaakaruode")
# ........................................................
kmw <- get_followers("vaakaruode") 
kmw

favorites <- rtweet::get_favorites(user = kmw$user_id[1], n = 1000)
# ........................................................
## search for a keyword
rt <- rtweet::search_tweets(q = "aluskate") # https://mkearney.github.io/nicar_tworkshop/#21
# ........................................................


# ........................................................
## get friends of multiple accounts
fds <- get_friends(c("vaakaruode", "jaakkotalonen"))
## frequency count of accounts followed by the users queried above
tbl <- table(fds$user_id)
## subset fds data to only those followed by 3 or more
fds3 <- subset(fds, user_id %in% names(tbl[tbl > 1L]))

# fds3$user_id <- fds3$user
## convert fds3 to matrix
mat <- as.matrix(fds3)
## convert to graph object
mat <- igraph::graph_from_edgelist(mat)
## plot network
plot(mat)
# ........................................................


library(rtweet)
rtweet_user(api_key = NULL, api_secret = NULL)

if (!auth_has_default() && interactive()) {
  auth_setup_default()
}


# Send tweet --------------------------------------------------------------
# https://www.r-bloggers.com/2022/01/tips-for-building-a-twitter-bot-with-r-and-github-actions/
# Create a token containing your Twitter keys
rbot_token <- rtweet::create_token(
  app = "aluskate",
  # the name of the Twitter app
  consumer_key = (cre$bot[2]),
  consumer_secret = (cre$bot[3]),
  access_token = (cre$bot[5]),
  access_secret = (cre$bot[6]),
  set_renv = FALSE
)

token <- create_token(
  app = "rstatsjournalismresearch",
  consumer_key = api_key,
  consumer_secret = api_secret_key)



book_status <- "test"
# Example: post a tweet via the API
rtweet::post_tweet(status = book_status,
                   token = rbot_token)
# ........................................................
# "You currently have Essential access which includes access to Twitter API v2 endpoints only. If you need access to this endpoint, you’ll need to apply for Elevated access via the Developer Portal. You can learn more here: https://developer.twitter.com/en/docs/twitter-api/getting-started/about-twitter-api#v2-access-leve"
# https://developer.twitter.com/en/portal/products/elevated
# ........................................................


if (FALSE) {
  # Use app auth for the remainder of this session:
  my_app <- rtweet::rtweet_app()
  auth_as(my_app)
  
  # Switch back to the default user based auth
  auth_as()
  
  # Load auth saved by auth_save()
  auth_as("my-saved-app")
}

